function wv_kid_to_uuid --wraps="base64 --decode | xxd -p | python -c 'import sys,uuid; print(uuid.UUID(hex=sys.stdin.readline().rstrip()))'" --description "alias wv_kid_to_uuid=base64 --decode | xxd -p | python -c 'import sys,uuid; print(uuid.UUID(hex=sys.stdin.readline().rstrip()))'"
    base64 --decode | xxd -p | python -c 'import sys,uuid; print(uuid.UUID(hex=sys.stdin.readline().rstrip()))' $argv
end
