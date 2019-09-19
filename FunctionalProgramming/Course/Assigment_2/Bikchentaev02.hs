{-# OPTIONS_GHC -Wall #-}

module Bikchentaev02 where

-- Task 1 -----------------------------------------
sumFr :: [Integer] -> Integer
sumFr [] = 0
sumFr xs = foldr (+) 0 xs

-- Task 2 ----------------------------------------- 
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = foldl (*) 1 [1 .. n]

-- Task 3 -----------------------------------------
concatFr :: [Integer] -> [Integer] -> [Integer]
concatFr [] [] = []
concatFr xs [] = xs
concatFr [] ys = ys
concatFr xs ys = foldr (:) ys xs

-- Task 4 -----------------------------------------
sortInsert :: [Integer] -> [Integer]
sortInsert [] = []
sortInsert xs = foldl insert [] xs

-- Task 5 -----------------------------------------
map2 :: (a -> b -> c) -> [a] -> [b] -> [c]
map2 _ [] [] = []
map2 _ _ [] = []
map2 _ [] _ = []
map2 func (x:xs) (y:ys) = (func x y) : (map2 func xs ys)

-- Task 6 -----------------------------------------
expPart :: Integer -> Integer -> Double
expPart m n =
  sum $ [(fromIntegral (m ^ i)) / (fromIntegral (factorial i)) | i <- [1 .. n]]

-- Task 7 -----------------------------------------
triangle :: [Integer]
triangle = scanl (+) 1 [2 ..]

-- Task 8 -----------------------------------------
piramid :: [Integer]
piramid = scanl (+) 1 [x * x | x <- [2 ..]]

-- Task 9 -----------------------------------------
indexes :: [Int] -> [Int] -> [Int]
indexes [] [] = [0]
indexes [] xs = [0 .. length xs]
indexes xs ys =
  [index | (item, index) <- zip (subsets xs ys) [0 ..], listsEqual xs item]

-- Helpers -----------------------------------------
insert :: [Integer] -> Integer -> [Integer]
insert xs x = (filter (<= x) xs) ++ [x] ++ (filter (> x) xs)

subsets :: [Int] -> [Int] -> [[Int]]
subsets _ [] = [[]]
subsets xs ys = (take (length xs) ys) : (subsets xs (tail ys))

listsEqual :: [Int] -> [Int] -> Bool
listsEqual [] [] = True
listsEqual [] _ = False
listsEqual _ [] = False
listsEqual (x:xs) (y:ys) = x == y && (listsEqual xs ys)
