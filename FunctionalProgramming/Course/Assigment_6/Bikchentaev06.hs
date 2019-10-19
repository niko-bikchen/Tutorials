{-# OPTIONS_GHC -Wall #-}

module Bikchentaev06 where

newtype Poly a =
  P [a]

-- Task 1 -----------------------------------------
x :: Num a => Poly a
x = P [0, 1]

-- Task 2 ----------------------------------------
instance (Num a, Eq a) => Eq (Poly a) where
  (==) (P []) (P []) = True
  (==) (P a) (P b) =
    let trimA = dropWhile (== 0) (reverse a)
        trimB = dropWhile (== 0) (reverse b)
     in trimA == trimB

-- Task 3 -----------------------------------------
instance (Num a, Eq a, Show a) => Show (Poly a) where
  show (P coefs) =
    if all (== 0) coefs
      then "0"
      else concatWithPlus $ formattedCoefs (reverse coefs)
    where
      formattedCoefs [] = []
      formattedCoefs (d:ds) = (showTerm d (length ds)) ++ formattedCoefs ds
      showTerm c e
        | c == 0 = []
        | c == 1 && e == 0 = ["1"]
        | otherwise = [showCoef c ++ showExp e]
      showCoef c
        | c == 1 = ""
        | c == -1 = "-"
        | otherwise = show c
      showExp e
        | e == 1 = "x"
        | e == 0 = ""
        | otherwise = "x^" ++ show e
      concatWithPlus [] = []
      concatWithPlus (term:[]) = term ++ concatWithPlus []
      concatWithPlus (term1:term2:[]) =
        term1 ++ " + " ++ term2 ++ concatWithPlus []
      concatWithPlus (term:terms) = term ++ " + " ++ concatWithPlus terms

-- Task 4 -----------------------------------------
plus :: Num a => Poly a -> Poly a -> Poly a
plus (P a) (P b)
  | length a < length b = P $ zipWith (+) b (a ++ (repeat 0))
  | length a > length b = P $ zipWith (+) a (b ++ (repeat 0))
  | otherwise = P $ zipWith (+) a b

-- Task 5 -----------------------------------------
times :: Num a => Poly a -> Poly a -> Poly a
times (P []) (P _) = P [0]
times (P (d:ds)) (P ys) = (P (map (* d) ys)) + (times (P ds) (P ([0] ++ ys)))

-- Task 6 -----------------------------------------
instance Num a => Num (Poly a) where
  (+) = plus
  (*) = times
  negate (P a) = P $ map (* (-1)) a
  fromInteger n = P [fromInteger n]
    -- No reasonable definition exists
  abs = undefined
  signum = undefined

-- Task 7 -----------------------------------------
applyP :: Num a => Poly a -> a -> a
applyP (P []) _ = 0
applyP (P (y:ys)) p =
  y +
  p *
  (if null ys
     then 0
     else applyP (P ys) p)

-- Task 8 -----------------------------------------
class Num a =>
      Differentiable a
  where
  deriv :: a -> a
  nderiv :: Int -> a -> a
  nderiv n f = (iterate deriv f) !! n

-- Task 9 -----------------------------------------
instance Num a => Differentiable (Poly a) where
  deriv (P []) = P [0]
  deriv (P (_:ys)) = P $ zipWith (*) ys (map fromInteger [1 ..])
