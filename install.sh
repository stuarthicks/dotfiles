#!/bin/bash
set -ux

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

link () {
  FILE=$1
  ln -s $DIR/$FILE $HOME/.$FILE
}

cd

mv .zshrc .zshrc.bak
mv .vimrc .vimrc.bak

link zshrc
link zprofile
link vimrc
link ackrc
link aliases
link mailcap
link rubocop.yml
link tmux.conf
link compton.conf
link pentadactylrc
link pentadactyl
link mintty_profile

touch $HOME/.path
touch $HOME/.profile

if git --help &>/dev/null; then
  # For ZSH plugin loading
  curl -sL https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > ~/antigen.zsh

  # For VIM plugin loading
  mkdir -p ~/.vim/autoload
  curl -fsLo ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +"PlugInstall" +qall

  ln -s etc/ftplugin .vim/ftplugin
fi


