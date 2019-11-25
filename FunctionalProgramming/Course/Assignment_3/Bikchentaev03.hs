{-# OPTIONS_GHC -Wall #-}

module Bikchentaev03 where

type Code = String

data Move =
  Move Code Int Int
  deriving (Show, Eq)

-- Task 1 -----------------------------------------
exactMatches :: Code -> Code -> Int
exactMatches [] [] = 0
exactMatches _ [] = 0
exactMatches [] _ = 0
exactMatches (x:xs) (y:ys)
  | x == y = 1 + exactMatches xs ys
  | otherwise = 0 + exactMatches xs ys

-- Task 2 -----------------------------------------
countDigits :: Code -> [Int]
countDigits "" = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
countDigits code = foldl incrementCounter [0, 0, 0, 0, 0, 0, 0, 0, 0, 0] code

-- Task 3 ----------------------------------------- 
matches :: Code -> Code -> Int
matches _ "" = 0
matches "" _ = 0
matches codeL codeR =
  sum
    [ min digitL digitR
    | (digitL, digitR) <- digitsCombined
    , (digitL /= 0) && (digitR /= 0)
    ]
  where
    digitsL = countDigits codeL
    digitsR = countDigits codeR
    digitsCombined = zip digitsL digitsR

-- Task 4 -----------------------------------------
getMove :: Code -> Code -> Move
getMove code attempt = Move attempt bulls cows
  where
    bulls = exactMatches code attempt
    cows = (matches code attempt) - bulls

-- Task 5 -----------------------------------------
isConsistent :: Move -> Code -> Bool
isConsistent (Move attempt1 bulls cows) attempt2 =
  bulls == otherBulls && cows == otherCows
  where
    otherBulls = exactMatches attempt1 attempt2
    otherCows = (matches attempt1 attempt2) - otherBulls

-- Task 6 -----------------------------------------
filterCodes :: Move -> [Code] -> [Code]
filterCodes move codes = filter (isConsistent move) codes

-- Task 7 -----------------------------------------
allCodes :: Int -> [Code]
allCodes 0 = []
allCodes 1 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
allCodes n = extend (n - 1) ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Task 8 -----------------------------------------
solve :: Code -> [Move]
solve code = solver code (allCodes (length code))

-- Helpers -----------------------------------------
charToInt :: Char -> Int
charToInt char = (fromEnum char) - (fromEnum '0')

incrementCounter :: [Int] -> Char -> [Int]
incrementCounter counters number_char = before ++ [(counter + 1)] ++ after
  where
    number = charToInt number_char
    before = take number counters
    after = drop (number + 1) counters
    counter = head $ drop number counters

extend :: Int -> [String] -> [Code]
extend 0 start = start
extend n start =
  extend
    (n - 1)
    [ number1 ++ number2
    | number1 <- start
    , number2 <- ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    ]

solver :: Code -> [Code] -> [Move]
solver _ [] = []
solver code (attempt:attempts) =
  currentMove : solver code (filter (currentMove `isConsistent`) attempts)
  where
    currentMove = getMove code attempt
