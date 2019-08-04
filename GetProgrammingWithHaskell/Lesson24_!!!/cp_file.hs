{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import System.Environment
import System.IO

main :: IO ()
main = do
  args <- getArgs
  let fileName = args !! 0
  let newFileName = args !! 1
  file_from <- openFile fileName ReadMode
  file_to <- openFile newFileName WriteMode
  file_from_contents <- hGetContents file_from
  hPutStr file_to file_from_contents
  hClose file_from
  hClose file_to
