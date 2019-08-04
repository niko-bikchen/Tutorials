reverser :: IO ()
reverser = do
  input <- getContents
  let reversed = reverse input
  putStrLn reversed

main :: IO ()
main = do
  userInput <- getContents
  mapM_ print userInput

toInts :: String -> [Int]
toInts = map read . lines

betterMain :: IO ()
betterMain = do
  userInput <- getContents
  let numbers = toInts userInput
  print (sum numbers)

squareInput :: IO ()
squareInput = do
  userInput <- getContents
  let numbers = map (\x -> x ^ 2) (toInts userInput)
  print (sum numbers)
