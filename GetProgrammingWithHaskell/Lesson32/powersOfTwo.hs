import Control.Monad

powersOfTwo :: Int -> [Int]
powersOfTwo n = do
  value <- [1 :: n]
  return (2 value)

powersOfTwoMap :: Int -> [Int]
powersOfTwoMap n = map (\x -> 2 ^ x) [1 .. n]

powersOfTwoAndThree :: Int -> [(Int, Int)]
powersOfTwoAndThree n = do
  value <- [1 .. n]
  let powersOfTwo = 2 ^ value
  let powersOfThree = 3 ^ value
  return (powersOfTwo, powersOfThree)

evensGuard :: Int -> [Int]
evensGuard n = do
  value <- [1 .. n]
  guard (even value)
  return value

powersOfTwoLCmprhnsns :: Int -> [Int]
powersOfTwo n = [value 2 | value <- [1 .. n]]

powersOfTwoAndThreeLCmprhnsns :: Int -> [(Int, Int)]
powersOfTwoAndThree n =
  [ (powersOfTwo, powersOfThree)
  | value <- [1 .. n]
  , let powersOfTwo = 2 ^ value
  , let powersOfThree = 3 ^ value
  ]
