module Files where

import System.Environment
import System.IO

catCom1 :: IO ()
catCom1 = do
  files <- hGetLine stdin
  contents <- mapM readFile (words files)
  let lis = [lines fileContent | fileContent <- contents]
  let allLines = concat lis
  let result =
        filter
          (\el ->
             if length el >= 2
               then take 2 el /= "--"
               else True)
          allLines
  hPutStrLn stdout $ unlines result
