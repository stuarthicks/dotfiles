#!/bin/ksh
#
# Copyright (c) 2012 Peter Ljung <ljung.peter@gmail.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

## Script that allow a new wifi connection to be setup interactively
# 
# Manual mode
# 1. User select wifi interface to use
# 2. Scan available networks (name, protection and signal strength)
# 3. User select network to connect to
# 4. User enter password for network (if not open)
# 5. Connect to network (assuming dhcp)
# 6. Optionally display a connect string to be appended to corresponding hostname.if file
#
# Automatic mode
# 1. User select wifi interface to use
# 2. Scan available networks (name, channel, security and signal strength)
# 3. Merge available networks with known networks
# 4. Automatically select then best known available network
# 5. Connect to network (assuming dhcp)
# 6. Optionally display a connect string to be appended to corresponding hostname.if file
#
# Other
# - TODO: Add connect line to hostname.if (instead of just printing)
# - TODO: Test with multiple known available networks
# - TODO: Replace known file with regular hostname.if
# - TODO: Handle spaces in password and nwid - DONE 
# - TODO: Automatically detect WEP/WPA security
# - TODO: Improve security for known file
#

# Default values
AUTO="true"    # Setup automatically if possible
INTERFACE=""   # E.g. "iwn0"
NETWORK=""     # E.g. "astrid;6;208dB;54M;secure" i.e. name, chan, signal, speed, secure/open
NAME=""        # E.g. "Astrid"
CHAN=""        # E.g. "6"
AUTHTYPE=""    # open, secure (i.e. wep or wpa), wep or wpa
PREFIX=""      # optional "0x" prefix to PASSWORD
PASSWORD=""    # "secret"
IF_STATUS=""   # "active" or "no network"
CONN_STR=""    # connect string for /etc/hostname.if
HNAME_FILE=""  # hostname.if file
KNOWN_FILE="/etc/known-wifi"

# Print input lines numbered from 1 .. n
print_lines_numbered() {
  awk '{print NR ". " $0}'
}

# Print single line identified by $1 (1..n)
print_line() {
  awk 'NR=='"$1"' {print $0}'
}

# Print the number of lines in file
lines() {
  wc -l $1 | awk '{ print $1 }'
}

# Strip $1 from " from both ends (not used!)
str_strip() {
  temp=${1#\"}
  echo "${temp%\"}"
}

# Print column n (1..) in $1 from string in $2 with ; as separator
col() {
  echo "$2" | eval "awk -F'[;]' '{ print \$"$1" }'"  # eval expands $1
}

# Get all interfaces (from dmesg output) as lines 
# TODO: Filter on WLAN interfaces (then unneccesary if selection with be removed)
get_all_interfaces() {
  dmesg | grep 'address' | awk '{ print $1 }' 
}

# Get network if from user
get_interface() {
  interfaces=$( get_all_interfaces )
  if [[ -n $INTERFACE ]]; then
    INTERFACE=$( print "$interfaces" | grep -i "^$INTERFACE" )
  fi
  if [[ -z $INTERFACE && -n $interfaces ]]; then
    num_ifs=`echo "$interfaces" | wc -l | awk '{ print $1 }'`
    if [[ $num_ifs -eq "1" ]]; then
      INTERFACE=$( print "$interfaces" | print_line "1" )
    elif [[ $num_ifs -gt "1" ]]; then
      print "Select which interface to configure:"
      print "$interfaces" | print_lines_numbered
      print -n "Select interface: "; read n
      INTERFACE=$( print "$interfaces" | print_line $n )
    fi
  fi
}

# Print all wifi interfaces from INTERFACE scan. First argument is optional separator.
# Columns: NAME;CHAN;signal;speed;AUTHTYPE
#          astrid;6;212dB;54M;secure
#          Time Capsule;4;242dB;54M;secure
get_all_networks() {
  ifconfig $INTERFACE scan | awk '/^\t+nwid/' | {
    while read l; do
      eval set -A ary "$l"      # set -A handles " quoting. eval is used expand $l
      SEC='open'
      if echo  ${ary[8]} | egrep -q 'privacy'; then
        SEC='secure'
      fi
      echo "${ary[1]};${ary[3]};${ary[6]};${ary[7]};$SEC"
    done
  }
}

# Let the user choose network based on interface scan. Set NAME, CHAN variables
# TODO: Test case with no available networks
get_network() {
  #networks=$( get_all_networks )
  networks=$( get_all_networks | sort -r -t';' -k3 )
  if [[ -n $NAME ]]; then
    NETWORK=$( print "$networks" | grep -i "^$NAME" )
  fi
  if [[ -z $NETWORK && -n $networks ]]; then
    # TODO: Make network list more readable by e.g. removing ; with space
    print "Select which network to connect to:"
    print "$networks" | print_lines_numbered
    print -n "Select network: "; read n
    NETWORK=$( print "$networks" | print_line $n )
  fi
  NAME=`col 1 "$NETWORK"`
  CHAN=`col 2 "$NETWORK"`
  AUTHTYPE=`col 5 "$NETWORK"`
}

# Get password from user. Set PASSWORD and AUTHTYPE if that can be determined from password type
get_password() {
  if [[ -z $PASSWORD ]]; then
    print -n "Enter password: "; read pw
    PASSWORD="$pw"
  fi
}

# Store current network as a known network. Replace network with same NAME
# Format: NAME;AUTHTYPE;PASSWORD
add_known_network() {
  # Use ; as field separator
  echo "$NAME;$AUTHTYPE;$PASSWORD" | cat $KNOWN_FILE - | sort -t';' -k1 -u > $TMP
  cat $TMP > $KNOWN_FILE
}

# Print known and available networks in signal strength order
# Format: NAME;AUTHTYPE;PASSWORD;CHAN;signal
known_available_networks() {
  # Print the join between known files and avail networks in signal strength order
  get_all_networks | sort -k1 > $TMP
  if [[ $( lines $TMP ) -gt 0 && $( lines $KNOWN_FILE ) -gt 0 ]]; then
    cat $KNOWN_FILE | sort -t';' -k1 | join -t';' - $TMP | sort -r -t';' -k6 | awk -F'[;]' '{ print $1";"$2";"$3";"$5";"$6 }'
  fi
}

# Set NAME, AUTHTYPE and PASSWORD to best (highest signal strength) available network
best_known_network() {
  BEST=$( known_available_networks | head -n 1 )
  if [[ -n $BEST ]]; then
    NAME=`col 1 "$BEST"`
    AUTHTYPE=`col 2 "$BEST"`
    PASSWORD=`col 3 "$BEST"`
    CHAN=`col 5 "$BEST"`
  fi
}

# Setup connection to open network. Based on INTERFACE, NAME, CHANNEL and PASSWORD. Update AUTHTYPE.
connect_open() {
  ifconfig $INTERFACE chan $CHAN nwid "$NAME" -nwkey -wpakey up
  sleep 5
}

# Setup WEP connection. $1 is an optional prefix to password.
connect_wep() {
  AUTHTYPE="wep"; PREFIX=$1
  ifconfig $INTERFACE chan $CHAN nwid "$NAME" -wpa -wpakey nwkey "$PREFIX$PASSWORD" up
  sleep 5
}

# Setup WPA connection. $1 is an optional prefix to password.
connect_wpa() {
  AUTHTYPE="wpa"; PREFIX=$1
  ifconfig $INTERFACE chan $CHAN nwid "$NAME" -nwkey wpa wpakey "$PREFIX$PASSWORD" up
  sleep 5
}

# Set interface down.
disconnect() {
  ifconfig $INTERFACE -chan -nwid -nwkey -wpa -wpakey down
  sleep 2
}

# Setup connection using open, wpa, wep. Update AUTHTYPE, PASSWORD and IF_STATUS.
connect() {
  if [[ "$AUTHTYPE" == "open" ]]; then
    connect_open
  elif [[ "$AUTHTYPE" == "wep" ]]; then
    connect_wep
  elif [[ "$AUTHTYPE" == "wpa" ]]; then
    connect_wpa
  elif [[ "$AUTHTYPE" == "secure" ]]; then
    # TODO: check that password is at least 8 characters (otherwise it is not wpa)
    if [[ $(if_status) != "active" ]]; then
      connect_wpa
    fi
    if [[ $(if_status) != "active" ]]; then
      if [[ "$PASSWORD" = +([a-f]|[0-9]) ]]; then 
        connect_wpa "0x"
      fi
    fi
    if [[ $(if_status) != "active" ]]; then
      connect_wep
    fi
    if [[ $(if_status) != "active" ]]; then
      if [[ "$PASSWORD" = +([a-f]|[0-9]) ]]; then 
        connect_wep "0x"
      fi
    fi
  else
	  echo "Unknown authentication type: $AUTHTYPE"
  fi
  PASSWORD="$PREFIX$PASSWORD"
  IF_STATUS=$(if_status)
}

dhclient_request() {
  dhclient $INTERFACE > /dev/null 2> /dev/null
}

# Get interface status (using ifconfig). Output: "active" or "no network"
if_status() {
  ifconfig "$INTERFACE" | grep 'status:' | sed 's/^.*status: //' 
}

# Connect string to be written to hostname.if. Based on NAME, CHANNEL, PASSWORD and AUTHTYPE.
connect_string() {
  HNAME_FILE="/etc/hostname.$INTERFACE"
	CONN_STR="dhcp chan $CHAN nwid \"$NAME\""
  if [[ $AUTHTYPE == "wep" ]]; then
	  CONN_STR="$CONN_STR nwkey \"$PREFIX$PASSWORD\"" 
  elif [[ $AUTHTYPE == "wpa" ]]; then
	  CONN_STR="$CONN_STR wpa wpakey \"$PREFIX$PASSWORD\""
  fi
}

initialize() {
  TMP=`mktemp` || exit 1
  touch $KNOWN_FILE
}

finalize() {
  rm "$TMP"
  exit 0
}

# Main ...
while getopts "i:n:p:t:f:m" opt; do
    case $opt in 
        i )    INTERFACE=$OPTARG ;;
        n )    NAME=$OPTARG ;;
        p )    PASSWORD=$OPTARG ;;
        t )    AUTHTYPE=$OPTARG ;;
        f )    KNOWN_FILE=$OPTARG ;;
        m )    AUTO="false" ;;
        \? )    print 'usage: sudo auto-wifi.sh [-i interface] [-n network_name] [-p password] [-t open/wep/wpa] [-f known_file] [-m(anual)]'
               return 1 ;;
    esac
done

initialize
get_interface; print
if [[ -z $INTERFACE ]]; then
  print "No interface available. Exit"; finalize
fi
if [[ $(if_status) == "active" ]]; then
  print -n "Interface ($INTERFACE) is active. Disconnect? ([y]n): "; read ANS
  if [[ $ANS == "n" ]]; then
    print "You cant setup an active interface. Exit"; finalize
  fi
  print
fi
disconnect
if [[ $AUTO == "true" ]]; then
  best_known_network
fi
get_network; print
if [[ -z $NAME ]]; then
  print "No network available. Exit"; finalize
fi
if [[ "$AUTHTYPE" != "open" ]]; then 
  get_password; print
fi
connect
dhclient_request
if [[ $(if_status) == "active" ]]; then
  add_known_network  # Ask user first?
  connect_string
  print "Interface ($INTERFACE) is active!"
  print -n "Do you want to add connect string to $HNAME_FILE? (y[n]): "; read ans
  if [[ $ans == "y" ]]; then
    print "Add the following line to $HNAME_FILE:"  # Remove! 
    print "$CONN_STR"
  fi
else
  print "Connection failed. Run script again to try again"
  print "Known password my be outdated. Do manual setup (-m) to override known password"
fi
finalize
