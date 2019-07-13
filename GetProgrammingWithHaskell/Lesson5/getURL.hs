getRequestURL host apiKey resource id =
  host ++ "/" ++ resource ++ "/" ++ id ++ "?token=" ++ apiKey

genHostRequestBuilder host =
  (\apiKey resource id -> getRequestURL host apiKey resource id)

exampleURL = genHostRequestBuilder "https://myexample.com"

genAPIRequestBuilder hostBuilder apiKey =
  (\resource id -> hostBuilder apiKey resource id)

genAPIRequestBuilder_withResource hostBuilder apiKey resource =
  (\id -> hostBuilder apiKey resource id)

exampleURLBuilder = getRequestURL "https://myexample.com"
myExampleURLBuilder = exampleURLBuilder "1337hAsk311"
