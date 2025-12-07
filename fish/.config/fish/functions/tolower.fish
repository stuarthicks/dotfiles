function tolower --wraps="tr '[:upper:]' '[:lower:]'" --description "alias tolower=tr '[:upper:]' '[:lower:]'"
    tr '[:upper:]' '[:lower:]' $argv
end
