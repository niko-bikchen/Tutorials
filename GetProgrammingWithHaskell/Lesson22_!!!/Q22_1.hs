import Data.List

digitToInt :: Char -> Maybe Int
digitToInt c = lookup c (zip ['0' .. '9'] [0 .. 9])

resolve :: Char -> Maybe Int -> Maybe Int -> Int
resolve '+' (Just a) (Just b) = a + b
resolve '-' (Just a) (Just b) = a - b

solve :: String -> Int
solve problem =
  if elem '+' problem
    then resolve '+' val1 val2
    else resolve '-' val1 val2
  where
    val1 = digitToInt (problem !! 0)
    val2 = digitToInt (problem !! 2)

main :: IO ()
main = do
  problem <- getContents
  print (solve problem)
