{-# OPTIONS_GHC -Wall #-}

module Bikchentaev07 where

data Stream a =
  Cons a (Stream a)

-- Task 1 -----------------------------------------
streamToList :: Stream a -> [a]
streamToList (Cons val stream) = [val] ++ (streamToList stream)

-- Task 2 -----------------------------------------
instance Functor Stream where
  fmap f (Cons val stream) = Cons (f val) (fmap f stream)

-- Task 3 -----------------------------------------
sRepeat :: a -> Stream a
sRepeat val = Cons val (sRepeat val)

sIterate :: (a -> a) -> a -> Stream a
sIterate f base = Cons base (sIterate f (f base))

sInterleave :: Stream a -> Stream a -> Stream a
sInterleave (Cons val1 stream1) (Cons val2 stream2) =
  Cons val1 (Cons val2 (sInterleave stream1 stream2))

sTake :: Int -> Stream a -> [a]
sTake 0 _ = []
sTake n (Cons val stream) = val : (sTake (n - 1) stream)

instance Show a => Show (Stream a) where
  show stream = (reverse $ tail $ reverse $ show $ sTake 20 stream) ++ ", ..."

-- Task 4 -----------------------------------------
nats :: Stream Integer
nats = sIterate (+ 1) 0

-- Task 5 -----------------------------------------
ruler :: Stream Integer
ruler = sInterleave oddPowerStream evenPowerStream
  where
    oddPowerStream = sRepeat 0
    evenStream = sIterate (+ 2) 2
    evenPowerStream = fmap (calcPower 0) evenStream

-- Task 6 -----------------------------------------
rand :: Integer -> Stream Integer
rand r0 =
  sIterate
    ((\r -> (1103515245 * r + 12345) `mod` 2147483648))
    ((1103515245 * r0 + 12345) `mod` 2147483648)

-- Task 7 -----------------------------------------
fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibs1 :: [Integer]
fibs1 = map fib [0 ..]

-- Task 8 -----------------------------------------
fibs2 :: [Integer]
fibs2 = 1 : 1 : zipWith (+) fibs2 (tail fibs2)

-- Task 9 -----------------------------------------
data Matrix a =
  M (a, a) (a, a)
  deriving (Show, Eq, Ord)

instance Num a => Num (Matrix a) where
  (+) (M (x11, x12) (x21, x22)) (M (y11, y12) (y21, y22)) =
    M (x11 + y11, x12 + y12) (x21 + y21, x22 + y22)
  (*) (M (x11, x12) (x21, x22)) (M (y11, y12) (y21, y22)) =
    M
      (y11 * x11 + y21 * x12, y12 * x11 + y22 * x12)
      (y11 * x21 + y21 * x22, y12 * x21 + y22 * x22)
  negate (M (x11, x12) (x21, x22)) = M (-x11, -x12) (-x21, -x22)
  fromInteger x = M (fromInteger x, 0) (0, fromInteger x)
    -- Not needed
  abs = undefined
  signum = undefined

-- Task 10 -----------------------------------------
fastFib :: Integer -> Integer
fastFib 0 = 1
fastFib 1 = 1
fastFib n = extractFib ((M (1, 1) (1, 0)) ^ n)

-- Helpers -----------------------------------------
calcPower :: Integer -> Integer -> Integer
calcPower power n =
  if n == 0
    then power
    else if n `mod` 2 == 0
           then calcPower (power + 1) (n `div` 2)
           else power

extractFib :: Matrix Integer -> Integer
extractFib (M (res, _) (_, _)) = res
