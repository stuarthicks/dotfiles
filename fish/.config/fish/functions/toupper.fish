function toupper --wraps="tr '[:lower:]' '[:upper:]'" --description "alias toupper=tr '[:lower:]' '[:upper:]'"
    tr '[:lower:]' '[:upper:]' $argv
end
