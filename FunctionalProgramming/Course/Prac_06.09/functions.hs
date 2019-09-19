sumList :: Num a => [a] -> a
sumList [] = 0
sumList (x:xs) = x + (sumList xs)

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
