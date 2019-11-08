def unmarshal_dynamodb:
  # DynamoDB string type
  (objects | .s)

  # DynamoDB blob type
  // (objects | .b)

  # DynamoDB number type
  // (objects | .n | strings | tonumber)

  # DynamoDB boolean type
  // (objects | .bOOL)

  # DynamoDB map type, recursion on each item
  // (objects | .m | objects | with_entries(.value |= unmarshal_dynamodb))

  # DynamoDB list type, recursion on each item
  // (objects | .l | arrays | map(unmarshal_dynamodb))

  # DynamoDB typed list type SS, string set
  // (objects | .sS | arrays | map(unmarshal_dynamodb))

  # DynamoDB typed list type NS, number set
  // (objects | .nS | arrays | map(tonumber))

  # DynamoDB typed list type BS, blob set
  // (objects | .bS | arrays | map(unmarshal_dynamodb))

  # managing others DynamoDB output entries: "Count", "Items", "ScannedCount" and "ConsumedCapcity"
  // (objects | with_entries(.value |= unmarshal_dynamodb))
  // (arrays | map(unmarshal_dynamodb))

  # leaves values
  // .
  ;
unmarshal_dynamodb
