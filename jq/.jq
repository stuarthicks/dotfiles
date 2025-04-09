def convertfrom_dynamodb:
    def _sprop($key): select(keys == [$key])[$key];                           # single property objects only
       ((objects | { value: _sprop("S") })                                    # string (from string)
    // (objects | { value: _sprop("s") })                                     # string (from string)
    // (objects | { value: _sprop("B") })                                     # blob (from string)
    // (objects | { value: _sprop("b") })                                     # blob (from string)
    // (objects | { value: _sprop("N") | tonumber })                          # number (from string)
    // (objects | { value: _sprop("n") | tonumber })                          # number (from string)
    // (objects | { value: _sprop("BOOL") })                                  # boolean (from boolean)
    // (objects | { value: _sprop("bool") })                                  # boolean (from boolean)
    // (objects | { value: _sprop("bOOL") })                                  # boolean (from boolean)
    // (objects | { value: _sprop("NULL") | null })                           # null (from null)
    // (objects | { value: _sprop("null") | null })                           # null (from null)
    // (objects | { value: _sprop("M") | map_values(convertfrom_dynamodb) })  # map (from object)
    // (objects | { value: _sprop("m") | map_values(convertfrom_dynamodb) })  # map (from object)
    // (objects | { value: _sprop("L") | map(convertfrom_dynamodb) })         # list (from encoded array)
    // (objects | { value: _sprop("l") | map(convertfrom_dynamodb) })         # list (from encoded array)
    // (objects | { value: _sprop("SS") })                                    # string set (from string array)
    // (objects | { value: _sprop("ss") })                                    # string set (from string array)
    // (objects | { value: _sprop("NS") | map(tonumber) })                    # number set (from string array)
    // (objects | { value: _sprop("ns") | map(tonumber) })                    # number set (from string array)
    // (objects | { value: _sprop("BS") })                                    # blob set (from string array)
    // (objects | { value: _sprop("bs") })                                    # blob set (from string array)
    // (objects | { value: map_values(convertfrom_dynamodb) })                # all other non-conforming objects
    // (arrays | { value: map(convertfrom_dynamodb) })                        # all other non-conforming arrays
    // { value: . }).value                                                    # everything else
    ;
