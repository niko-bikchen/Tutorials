{-# OPTIONS_GHC -Wall #-}
module Bikchentaev03 where

type Code = String

data Move = Move Code Int Int
          deriving (Show, Eq)

-- Task 1 -----------------------------------------
exactMatches :: Code -> Code -> Int
exactMatches = undefined

-- Task 2 -----------------------------------------
countDigits :: Code -> [Int]
countDigits = undefined

-- Task 3 ----------------------------------------- 
matches :: Code -> Code -> Int
matches = undefined
 
-- Task 4 -----------------------------------------
getMove :: Code -> Code -> Move
getMove = undefined

-- Task 5 -----------------------------------------
isConsistent :: Move -> Code -> Bool
isConsistent = undefined

-- Task 6 -----------------------------------------
filterCodes :: Move -> [Code] -> [Code]
filterCodes = undefined

-- Task 7 -----------------------------------------
allCodes :: Int -> [Code]
allCodes = undefined
   
-- Task 8 -----------------------------------------
solve :: Code -> [Move]
solve = undefined
 
