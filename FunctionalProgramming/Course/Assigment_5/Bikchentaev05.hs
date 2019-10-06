{-# OPTIONS_GHC -Wall #-}

module Bikchentaev05 where

import Control.Monad

data BinTree a
  = ALeaf a
  | ABranch (BinTree a) (BinTree a) (BinTree a)
  deriving (Eq, Show)

type Graph = [[Int]]

-- Task 1 ------------------------------------------
lucky :: Int -> [String]
lucky 0 = []
lucky n = ((filter isLucky) . nLengthNumbers) (n * 2)

-- Task 2 -----------------------------------------  
queens :: Int -> [[Int]]
queens n = reverse $ map fst $ foldM oneMoreQueen ([], [1 .. n]) [1 .. n]
  where
    oneMoreQueen (y, d) _ = [(x : y, removeEl x d) | x <- d, safe x]
      where
        safe x = and [x /= c + num && x /= c - num | (num, c) <- zip [1 ..] y]

-- Task 3 -----------------------------------------
maxLen :: [Int] -> Int
maxLen [] = 0
maxLen list = maximum (map length (allAscSublists list))

-- Task 4 -----------------------------------------
maxSeq :: [Int] -> [Int]
maxSeq [] = []
maxSeq list =
  last $ filter (\subLst -> (length subLst) == lenMax) (allAscSublists list)
  where
    lenMax = maxLen list

-- Task 5 -----------------------------------------
allMaxSeq :: [Int] -> [[Int]]
allMaxSeq list =
  filter (\subLst -> (length subLst) == lenMax) (allAscSublists list)
  where
    lenMax = maxLen list

-- Task 6 -----------------------------------------
genExpr :: Int -> Int -> [String]
genExpr number result =
  convertRPN $
  head $
  set
    [ expr
    | operationSet <- operationSets
    , expr <- insertOperationSet numberStr operationSet
    , (solveRPN expr) == result
    ]
  where
    numberStr = show number
    operationSets = generateOperationSets numberStr

-- Task 7 -----------------------------------------
genExprBracket :: Int -> Int -> [String]
genExprBracket = undefined

-- Task 8 -----------------------------------------
topolSortAll :: Graph -> [[Int]]
topolSortAll = undefined

--------------------------------------------
gr1 :: Graph
gr1 = [[1, 2, 3], [], [3, 4], [4], []]

-- Helpers -----------------------------------------
nLengthNumbers :: Int -> [String]
nLengthNumbers 0 = []
nLengthNumbers n =
  extend (n - 1) ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

extend :: Int -> [String] -> [String]
extend 0 start = start
extend n start =
  extend
    (n - 1)
    [ number1 ++ number2
    | number1 <- start
    , number2 <- ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    ]

isLucky :: String -> Bool
isLucky numStr = sum fstHalf == sum sndHalf
  where
    numLen = length numStr
    fstHalf = [fromChrToInt numChr | numChr <- take (numLen `div` 2) numStr]
    sndHalf =
      [fromChrToInt numChr | numChr <- take (numLen `div` 2) (reverse numStr)]

fromChrToInt :: Char -> Int
fromChrToInt chr = (fromEnum chr) - (fromEnum '0')

removeEl :: Eq a => a -> [a] -> [a]
removeEl _ [] = []
removeEl x (y:ys)
  | x == y = removeEl x ys
  | otherwise = y : removeEl x ys

ascFromOne :: Int -> Int -> [Int] -> [Int]
ascFromOne _ _ [] = []
ascFromOne base other list
  | other >= (length list) = []
  | (list !! other) > (list !! base) =
    (list !! other) : (ascFromOne other (other + 1) list)
  | otherwise = ascFromOne base (other + 1) list

allAscSublists :: [Int] -> [[Int]]
allAscSublists [] = [[]]
allAscSublists list =
  set
    [ (list !! base) : (ascFromOne base other list)
    | base <- [0 .. (listLen - 1)]
    , other <- [(base + 1) .. (listLen - 1)]
    ]
  where
    listLen = length list

set :: Eq a => [a] -> [a]
set [] = []
set (x:xs) = x : (set (removeEl x xs))

insert :: a -> [a] -> [[a]]
insert v [] = [[v]]
insert v (y:ys) = (v : y : ys) : (map (y :) (insert v ys))

permit :: Int -> String -> [String]
permit 0 _ = [[]]
permit n st = [x : y | x <- st, y <- permit (n - 1) st]

generateOperationSets :: String -> [String]
generateOperationSets num = permit (numLen - 1) "+-*"
  where
    numLen = length num

insertOperationSet :: String -> String -> [String]
insertOperationSet number [] = [number]
insertOperationSet number (operation:operations) =
  insertionHelper (insert operation number) operations

insertionHelper :: [String] -> String -> [String]
insertionHelper numbers [] = numbers
insertionHelper numbers (operation:operations) =
  insertionHelper
    [item | array <- map (insert operation) numbers, item <- array]
    operations

solveRPN :: (Num a, Read a) => String -> a
solveRPN = head . foldl foldingFunction [] . stringToListOfStrings
  where
    foldingFunction (x:y:ys) "*" = (x * y) : ys
    foldingFunction (x:y:ys) "+" = (x + y) : ys
    foldingFunction (x:y:ys) "-" = (y - x) : ys
    foldingFunction xs numberString = read numberString : xs

stringToListOfStrings :: String -> [String]
stringToListOfStrings string = [item : "" | item <- string]

convertRPN :: String -> [String]
convertRPN = foldl foldingFunction [] . stringToListOfStrings
  where
    foldingFunction (x:y:ys) "*" = (y ++ "*" ++ x) : ys
    foldingFunction (x:y:ys) "+" = (y ++ "+" ++ x) : ys
    foldingFunction (x:y:ys) "-" = (y ++ "-" ++ x) : ys
    foldingFunction xs numberString = numberString : xs
