{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import System.Environment
import System.IO

main :: IO ()
main = do
  putStrLn "Enter file to capitalize"
  fileName <- getLine
  fileContents <- TIO.readFile fileName
  TIO.writeFile fileName (T.toUpper fileContents)
