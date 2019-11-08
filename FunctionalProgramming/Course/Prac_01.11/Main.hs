{-# OPTIONS_GHC -Wall #-}

-- Main < Main.hs > res.txt
-- str <- getContents
-- putStrLn (counting str)
-- ns <- getArgs
-- fc <- readAll ns
-- putStrLn (counting fc)
-- Rose tree
-- Multi-way tree
-- Data.Tree
module Main where

import Counting
import System.Environment

main :: IO ()
main = do
  args <- getArgs
  contents <-
    if null args
      then getContents
      else readAll args
  putStrLn (counting contents)

readAll :: [String] -> IO String
readAll [] = return ""
readAll (n:ns) = do
  cf1 <- readFile n
  cfa <- readAll ns
  return (cf1 ++ "\n" ++ cfa)
