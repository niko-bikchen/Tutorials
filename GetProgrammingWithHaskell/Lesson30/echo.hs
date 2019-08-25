echo :: IO ()
echo = getLine >>= putStrLn

main :: IO ()
main = echo

doMain :: IO ()
doMain = do
  input <- getLine
  putStrLn input
