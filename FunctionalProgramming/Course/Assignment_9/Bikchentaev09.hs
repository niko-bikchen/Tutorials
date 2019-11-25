{-# OPTIONS_GHC -Wall #-}

module Bikchentaev09 where

import Data.List (subsequences)

data SuffixTree
  = Leaf Int
  | Node [(String, SuffixTree)]
  deriving (Eq, Ord, Show)

-- Task 1 -----------------------------------------
isPrefix :: String -> String -> Bool
isPrefix str1 str2
  | length str1 > length str2 = False
  | str1 == "" = True
  | otherwise = take (length str1) str2 == str1

-- Task 2 -----------------------------------------
partition :: Eq a => [a] -> [a] -> ([a], [a], [a])
partition str1 str2 = (gcp, drop (length gcp) str1, drop (length gcp) str2)
  where
    gcp = greatestCommonPrefix str1 str2

greatestCommonPrefix :: Eq a => [a] -> [a] -> [a]
greatestCommonPrefix [] _ = []
greatestCommonPrefix _ [] = []
greatestCommonPrefix (chr1:str1) (chr2:str2)
  | chr1 == chr2 = chr1 : greatestCommonPrefix str1 str2
  | otherwise = []

-- Task 3 -----------------------------------------
suffixes :: [a] -> [[a]]
suffixes str = [drop n str | n <- [0 .. (length str) - 1]]

-- Task 4 -----------------------------------------
isSubstring :: String -> String -> Bool
isSubstring str1 str2
  | length str1 > length str2 = False
  | otherwise = or $ map (isPrefix str1) (suffixes str2)

-- Task 5 -----------------------------------------
findSubstrings :: String -> String -> [Int]
findSubstrings str1 str2
  | length str1 > length str2 = []
  | otherwise =
    filter (>= 0) $
    map
      (\el ->
         if isPrefix str1 (fst el)
           then snd el
           else -1)
      (zip (suffixes str2) [0 ..])

-- Task 6 -----------------------------------------
getIndices :: SuffixTree -> [Int]
getIndices (Leaf x) = [x]
getIndices (Node []) = []
getIndices (Node (tup:tups)) =
  concat [(getIndices (snd tup)), (getIndices (Node tups))]

-- Task 7 -----------------------------------------
findSubstrings' :: String -> SuffixTree -> [Int]
findSubstrings' _ (Leaf _) = []
findSubstrings' _ (Node []) = []
findSubstrings' s (Node ((x, xs):xxs))
  | isPrefix s x = getIndices xs
  | isPrefix x s = findSubstrings' (flip drop s (length x)) xs
  | otherwise = findSubstrings' s (Node xxs)

-- Task 8 -----------------------------------------
insert :: (String, Int) -> SuffixTree -> SuffixTree
insert (_, _) (Leaf a) = Leaf a
insert item (Node ts) = Node (hIns item ts)
  where
    hIns (s, n) [] = [(s, Leaf n)]
    hIns (s, n) ((a, t):trs)
      | null p = (a, t) : hIns (s, n) trs
      | p == a = (a, insert (r, n) t) : trs
      | otherwise = (p, Node [(r', t), (r, (Leaf n))]) : trs
      where
        (p, r, r') = partition s a

-- Suffix tree builder -----------------------------------------
buildTree :: String -> SuffixTree
buildTree s = foldl (flip insert) (Node []) (zip (suffixes s) [0 ..])

-- Task 9 -----------------------------------------
longestRepeatedSubstring :: SuffixTree -> String
longestRepeatedSubstring tree =
  longestSubstring "" $
  filter (\el -> length (snd el) >= 2) $
  map
    (\el -> (el, findSubstrings' el tree))
    (subsequences (fst (head (unwrp tree))))

longestSubstring :: String -> [(String, [Int])] -> String
longestSubstring maxi [] = maxi
longestSubstring maxi ((str, _):rest)
  | length str > length maxi = longestSubstring str rest
  | otherwise = longestSubstring maxi rest

unwrp :: SuffixTree -> [(String, SuffixTree)]
unwrp (Node listOfPairs) = listOfPairs
unwrp (Leaf _) = [("", Node [])]

-- Test data -----------------------------------------
s1 :: String
s1 = "banana"

s2 :: String
s2 = "mississippi"

t1 :: SuffixTree
t1 =
  Node
    [ ("banana", Leaf 0)
    , ("a", Node [("na", Node [("na", Leaf 1), ("", Leaf 3)]), ("", Leaf 5)])
    , ("na", Node [("na", Leaf 2), ("", Leaf 4)])
    ]

t2 :: SuffixTree
t2 =
  Node
    [ ("mississippi", Leaf 0)
    , ( "i"
      , Node
          [ ("ssi", Node [("ssippi", Leaf 1), ("ppi", Leaf 4)])
          , ("ppi", Leaf 7)
          , ("", Leaf 10)
          ])
    , ( "s"
      , Node
          [ ("si", Node [("ssippi", Leaf 2), ("ppi", Leaf 5)])
          , ("i", Node [("ssippi", Leaf 3), ("ppi", Leaf 6)])
          ])
    , ("p", Node [("pi", Leaf 8), ("i", Leaf 9)])
    ]
