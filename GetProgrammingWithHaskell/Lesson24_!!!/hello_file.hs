import System.IO

main :: IO ()
main = do
  helloFile <- openFile "hello.txt" ReadMode
  firstLine <- hGetLine helloFile
  putStrLn firstLine
  secondLine <- hGetLine helloFile
  goodbyeFile <- openFile "goodbye.txt" WriteMode
  hPutStrLn goodbyeFile secondLine
  hClose helloFile
  hClose goodbyeFile
  putStrLn "Done"

anotherMain :: IO ()
anotherMain = do
  helloFile <- openFile "hello.txt" ReadMode
  isEnd <- hIsEOF helloFile
  firstLine <-
    if isEnd
      then hGetLine helloFile
      else return "empty"
  putStrLn "Done"
