# 6 September 2019

## Introduction.

# 10 September 2019

## Functions

## Case experession

``` 
sum1 :: [Int] -> [Int]
sum xs = if null xs
            then 0
            else head xs + sum (tail xs)
```

*OR*

``` 
sum1 :: [Int] -> [Int]
sum xs = case xs of
            [] -> 0
            (y:ys) -> y + sum1 ys
```

## Clauses

``` 
sum1 :: [Int] -> [Int]
sum1 [] = 0
sum1 (x:xs) = x + (sum1 xs)
```

*Clauses are the syntactic sugar for case expressions*

``` 
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = (f x) : (map f xs)
```

## Pattern matching

``` 
(x:y:[]) == [x, y]
```

y@(x:xs) - *Named pattern where "y" is the name*

``` 
dup1 :: [Int] -> [Int]
dup1 [] = []
dup1 (x:xs) = x : x : xs
dup l@(x:_) = x : l
```

## Lambdas

## Guards

``` 
compareBegin [1, 2, 3, 4] = 1 < 2 => L otherwise G
```

``` 
compareBegin :: [Int] -> Char
compareBegin (x:y:_) | x < y = 'L'
                     | x > y = 'G'
comapreBegin _ = 'N'
```

*If the previos equation didn't match our input, the last one will be executed*
*If the last one didn't match than exeption is thrown*
*Equations will be matched one by one. If any equation didn't match exeption is thrown*

## Local names

## Function composition

## Functions and operators

# 17 September 2019

# Data types

## Basic types

``` 
Char, Int, Integer, Float, Double
```

## Types with built in syntax

``` 
Lists (e.g [Int]), Tuples (e.g (a, b, c), (Int, Char) and Int -> Int which is a functional type
```

*Constructors and types with built in syntax have similar syntax, like (Int, Char) => constructor (5, 'a')*
*Trivial tuple ()*

## type keyword

``` 
type String = [Char]
```

``` 
type Point a = (a, a)
``` 
*Point Float is (Float, Float)*

## data keyword

` `  ` data Shape = Ellipse Float Float | Square Float | Poligon [(Float, Float)] `  ` ` 

*Every data constructor is a function*

```

Ellipse :: Float -> Float -> Shape

``` 
```
Poligon :: [(Float, Float)] -> Shape
```

``` 
Ellipse 5.0 6.0
```

``` 
infSh :: Shape -> String
infSh (Poligon p@(_:(_:_)) = "Poligon width is" ++ show(length (p - 1)) ++ " segments"
infSh (Square (Square x) = "Square width" ++ (show x)```

infSh _ = ""

``` 

```

data Shape = Ellipse Float Float | Square Float | Poligon [(Float, Float)] deriving Show

``` 

## Bool

```

data Bool = True | False

``` 

## Maybe

```

data Maybe a = Nothing | Just a

``` 

```

safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv a b 

            | a ` `  ` mod `  `  ` b == 0 = Just $ a ` ` `div

``` b
            | otherwise = Nothing
```

## Either

``` 
data Either a b = Left a | Right b
```

``` 
safeDivUltimate :: Int -> Int -> Either String Int
safeDivUltimate _ 0 = Left "Cannot divide by 0"
safeDivUltimate a b

                    | a ` `  ` mod `  `  ` b = Right $ a `  `  ` div `  ` ` b
                    | otherwise = Left "Second argument is not a divisor of the first argument"

```

## Recursive data types

``` 
data Name = Con1 ... | Con2 ...
```

*...can be replaced with other data types or with a Name type*

``` 
data Branch a = Leaf a | Fork (Branch a) (Branch a) deriving Show
```

``` 
Leaf 7
```

``` 
Fork (Leaf 7) (Fork (Leaf 5) (Leaf 1))
```

``` 
countLeafSum :: Branch Int -> Int
countLeafSum (Leaf a) = a
countLeafSum (Fork l r) = (countLeafSum l) + (countLeafSum r)
```

``` 
data Point = Point Float Float deriving Show
```

``` 
pt = Point 5.0 6.0
```

``` 
abs :: Point -> Float
abs (Point x y) = sqrt $ ` `  ` x*x + y*y `  ` ` 
```

## Using record syntax to init data Point

data Point = Point {

    px :: Float,
    py :: Float

}

*px and py are "getters" (i.e.functions) automatically created to get Point fields*

``` 
abs p = sqrt $ px p * px p + py p * py p
```

## newtype keyword

``` 
type Apple = Int
type Orange = Int

a :: Apple
a = 5

b :: Orange
b = 10

a + b -- Works fine, but it's wrong

data Apple = Apple Int
data Orange = Orange Int

a :: Apple
a = Apple 5

b :: Orange
b = Orange 10

a + b -- Throws error, but we used data keyword to create a wrap which is an overhead

newtype Apple = Apple Int
newtype Orange = Orange Int

a :: Apple
a = Apple 5

b :: Orange
b = Orange 10

a + b -- Works fine
```

*Newtype works like data but has less functionality, like it only allows one constructor*

# 1 October 2019

# Type classes

## Declaring a type class

``` 
class Name a where
    f1 :: y1 -> ...
    f2 :: y2 -> ...
```

``` 
instance Name Who where
    f1 :: y1 -> ...
    -- implement all functions
```

``` 
class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    x == y = not (x /= y)
    x /= y = not (x == y)
```

``` 
instance Eq a => Eq [a] where
    [] == [] = True
    (x:xs) == (y:ys) = (x==y) && (xs == ys)
    _ == _ = False
```

``` 
class Ordering = LT | EQ | GT
```

``` 
class Eq a => Ord a where
    compare :: a -> a -> Ordering
    (<), (<=), (>), (>=) :: a -> a -> Bool
    min, max :: a -> a -> a

compare x y = if x == y then EQ else if x <= y then LT else GT
```

``` 
data Branch a = Leaf a | Fork (Branch a) (Branch a)

instance Eq a => Eq (Branch a) where
    Leaf x == Leaf y = x == y
    Fork l r == Fork l1 r1 = (l == l1) && (r == r1)
    _ == _ = False

-- OR

data Branch a = Leaf a | Fork (Branch a) (Branch a) deriving (Eq, Ord, Show)
```

# 8 October 2019

# Monads, Applicatives, Functors, etc.

## Functor

## Applicative

# 15 October 2019

# Introcuction to Monads

``` 
f1 :: [a] -> [b] -> [Bool]
f2 :: f a -> f b -> f Bool
```

``` 
toInt :: String -> Maybe Int
toInt s 
    | all (isDigit s) = Just $ read s
    | otherwise = Nothing

addTwo :: String -> Maybe Int
addTwo s = (+2) <$> (toInt s)

addTwoIO :: IO (Maybe Int)
addTwoIO = addTwo <$> getLine

addS :: String -> String -> Maybe Int
addS s1 s2 = 
    (+) <$> (toInt s1) <*> (toInt s2)

addSIO :: IO (Maybe Int)
addSIO = addS <$> getLine <*> getLine
```

``` 
data Person = Person String deriving (Show)

mother, father :: Person -> Maybe Person
mf, mff :: Person -> Maybe Person
mf p = case mother p of
        Nothing -> Nothing
        Just m -> case father m of
                    Nothing -> Nothing
                    Just mf -> father mf

-- Looks bad cuz its will become longer every time we find a new father
-- We can use combinator

comb :: a -> (a -> Maybe) -> Maybe a
comb Nothing f = Nothing
comb (Just a) f = f a

mf p = ((Just p) `comb` mother) `comb` father
mff p = (((Just p) `comb` mother) `comb` father) `comb` father
```

``` 
instance Monad Maybe where
    return x = Just x
    Nothing f = Nothing
    (Just x) f = f x

mf p = (return p) >>= mother >>= father ... >>= father
```

``` 
addSIO :: IO ()
addSIO = addS <$> getLine <*> getLine >>= print

print :: a -> IO ()
print x = putStrLn (show x)
```

