{-# OPTIONS_GHC -Wall #-}

module Bikchentaev01 where

-- Task 1 -----------------------------------------
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Task 2 -----------------------------------------
listSum :: [Int] -> [Int] -> [Int]
listSum [] [] = []
listSum (x:xs) [] = x : (listSum xs [])
listSum [] (y:ys) = y : (listSum [] ys)
listSum (x:xs) (y:ys) = (x + y) : (listSum xs ys)

-- Task 3 ----------------------------------------- 
oddEven :: [Int] -> [Int]
oddEven [] = []
oddEven (x:[]) = x : (oddEven [])
oddEven (x:y:xs) = y : x : (oddEven xs)

-- Task 4 -----------------------------------------
position :: Int -> [Int] -> Int
position _ [] = -1
position n xs =
  if (length indexes) >= 1
    then head indexes
    else -1
  where
    indexes = [index | (x, index) <- zip xs [0 ..], x == n]

-- Task 5 -----------------------------------------
set :: [Int] -> [Int]
set [] = []
set (x:xs) = x : (set (remove x xs))

-- Task 6 -----------------------------------------
union :: [Int] -> [Int] -> [Int]
union xs ys = set (merge xs ys)

-- Task 7 -----------------------------------------
intersection :: [Int] -> [Int] -> [Int]
intersection [] [] = []
intersection xs [] = []
intersection [] ys = []
intersection xs ys = set ([x | x <- xs, x `elem` ys])

-- Task 8 -----------------------------------------
factorialsM :: [Integer]
factorialsM = [factorial x | x <- [1 ..]]

-- Helpers -----------------------------------------
remove :: Int -> [Int] -> [Int]
remove _ [] = []
remove x (y:ys)
  | x == y = remove x ys
  | otherwise = y : (remove x ys)

merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) = x : y : (merge xs ys)
