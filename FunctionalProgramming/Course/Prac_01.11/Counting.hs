{-# OPTIONS_GHC -Wall #-}

module Counting where

counting :: String -> String
counting str =
  let ls = lines str
      ws = concatMap words ls
      cc = sum $ map length ws
   in show (length ls, length ws, cc)
