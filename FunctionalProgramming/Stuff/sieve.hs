isPrime :: Int -> Bool
isPrime 1 = False
isPrime 2 = True
isPrime n
  | (length [x | x <- [2 .. n - 1], mod n x == 0]) > 0 = False
  | otherwise = True

twoPrimes :: Int -> Maybe (Int, Int)
twoPrimes n =
  if length correctPairs == 0
    then Nothing
    else Just $ head $ correctPairs
  where
    correctPairs =
      [ (a, b)
      | a <- [n,n - 1 .. 0]
      , b <- [0 .. n]
      , (isPrime a) && (isPrime b) && (a + b == n)
      ]
