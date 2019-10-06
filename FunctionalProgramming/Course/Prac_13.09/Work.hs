{-# OPTIONS_GHC -Wall #-}

module Work where

foo :: [Int] -> [Int]
foo [] = []
foo xs = [num | x <- xs, let num = length (filter (< x) xs)]

cntLess :: [Int] -> Int -> Int
cntLess [] _ = 0
cntLess xs x = length (filter (< x) xs)

foo2 :: [Int] -> [Int]
foo2 [] = []
foo2 xs = map (cntLess xs) xs

allPrefix :: [Int] -> [[Int]]
allPrefix [] = []
allPrefix xs = [pref | i <- [1 .. length xs], let pref = take i xs]

sumM :: [Int] -> Int
sumM [] = 0
sumM (x:xs) = x + (sumM xs)

cumSumPrefix :: [Int] -> [Int]
cumSumPrefix xs = map sumM (allPrefix xs)

diff :: [Int] -> [Int] -> [Int]
diff [] [] = []
diff xs [] = xs
diff [] _ = []
diff xs ys = [x | x <- xs, x `notElem` ys]

minFree :: [Int] -> Int
minFree [] = 0
minFree xs = (head . (diff [0 ..])) xs
