{-# OPTIONS_GHC -Wall #-}

module Bikchentaev05 where

import Control.Monad

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
genExpr number result = convertRPN $ head $ allExpr number result

-- Task 7 -----------------------------------------
genExprBracket :: Int -> Int -> [String]
genExprBracket number result = answerReady
  where
    answerRaw = map convertRPNWithBrackets (allExpr number result)
    answerReady = map head answerRaw

-- Task 8 -----------------------------------------
topolSortAll :: Graph -> [[Int]]
topolSortAll [] = []
topolSortAll [[]] = [[]]
topolSortAll graph
  | not (isAcyclic graph) = []
  | otherwise =
    [ sort
    | sort <- change [0 .. ((length graph) - 1)]
    , isTopolSort (allPrefixes sort) graph
    ]

--------------------------------------------
gr1 :: Graph
gr1 = [[1, 2, 3], [], [3, 4], [4], []]

-- Helpers -----------------------------------------
isTopolSort :: [[Int]] -> [[Int]] -> Bool
isTopolSort prefixes graph =
  and [isValidPrefix (head prefix) (tail prefix) graph | prefix <- prefixes]

isValidPrefix :: Int -> [Int] -> [[Int]] -> Bool
isValidPrefix _ [] _ = True
isValidPrefix fstNode (node:prefix) graph
  | edgeExists fstNode node graph = True && (isValidPrefix fstNode prefix graph)
  | otherwise =
    not (edgeExists node fstNode graph) && (isValidPrefix fstNode prefix graph)

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

convertRPNWithBrackets :: String -> [String]
convertRPNWithBrackets = foldl foldingFunction [] . stringToListOfStrings
  where
    foldingFunction (x:y:ys) "*" = ("(" ++ y ++ "*" ++ x ++ ")") : ys
    foldingFunction (x:y:ys) "+" = ("(" ++ y ++ "+" ++ x ++ ")") : ys
    foldingFunction (x:y:ys) "-" = ("(" ++ y ++ "-" ++ x ++ ")") : ys
    foldingFunction xs numberString = numberString : xs

change :: [a] -> [[a]]
change [] = [[]]
change (x:xs) = concat (map (insert x) (change xs))

allExpr :: Int -> Int -> [String]
allExpr number result =
  set
    [ expr
    | operationSet <- operationSets
    , expr <- insertOperationSet numberStr operationSet
    , (solveRPN expr) == result
    ]
  where
    numberStr = show number
    operationSets = generateOperationSets numberStr

edgeExists :: Int -> Int -> [[Int]] -> Bool
edgeExists nodeStart nodeEnd graph = nodeEnd `elem` (graph !! nodeStart)

allPrefixes :: [Int] -> [[Int]]
allPrefixes [] = []
allPrefixes xs = [pref | i <- [0 .. (length xs) - 1], let pref = drop i xs]

isAcyclic :: Graph -> Bool
isAcyclic [] = True
isAcyclic [[]] = True
isAcyclic graph =
  null
    [ way
    | node <- allNodes graph
    , ways <- allWays graph node
    , way <- ways
    , way /= [] && (length way >= 2) && ((head way) == (last way))
    ]

allNodes :: Graph -> [Int]
allNodes graph = [0 .. ((length graph) - 1)]

allEdges :: Graph -> [(Int, Int)]
allEdges graph = [(x, y) | x <- (allNodes graph), y <- graph !! x]

allWays :: Graph -> Int -> [[[Int]]]
allWays graph vertex = until condW (stepW graph) [[[vertex]]]

condW :: ([[[Int]]]) -> Bool
condW wss = null (head wss)

stepW :: Graph -> [[[Int]]] -> [[[Int]]]
stepW _ [] = error "allWays:stepW"
stepW graph wss@(wsn:_) =
  [t : w | w@(v:vs) <- wsn, notElem v vs, t <- graph !! v] : wss
