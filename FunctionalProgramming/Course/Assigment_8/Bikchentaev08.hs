{-# OPTIONS_GHC -Wall #-}

module Bikchentaev08 where

import Data.List (isInfixOf)
import Data.Maybe
import Data.Tree

ot1, ot2, ot3 :: Tree Char
ot1 = Node 'A' []

ot2 = Node 'A' [Node 'B' []]

ot3 = Node 'C' [Node 'B' [], Node 'C' []]

ot4, ot5, ot6, ot7 :: Tree Int
ot4 = Node 1 [Node 2 [Node 4 [], Node 5 []], Node 3 []]

ot5 = Node 1 [Node 2 [], Node 3 []]

ot6 = Node 1 [Node 2 [], Node 3 [Node 10 []]]

ot7 = Node 4 [Node 5 [Node 8 []], Node 6 [Node 9 []], Node 7 []]

bt1 :: BTree Int
bt1 =
  BNode
    5
    (BNode 3 (BNode 2 BEmpty BEmpty) (BNode 4 BEmpty BEmpty))
    (BNode 10 BEmpty BEmpty)

data BTree a
  = BEmpty
  | BNode a (BTree a) (BTree a)
  deriving (Show, Eq)

-- Task 1 -----------------------------------------
dfsForest :: Forest a -> [a]
dfsForest [] = []
dfsForest (Node x []:ts) = x : dfsForest ts
dfsForest (Node x xs:ts) = x : (dfsForest xs) ++ dfsForest ts

-- Task 2 ----------------------------------------- 
bfsForest :: Forest a -> [a]
bfsForest [] = []
bfsForest (Node x xs:ts) = x : (bfsForest (ts ++ xs))

-- Task 3 -----------------------------------------
isInTree :: (Eq a) => Tree a -> Tree a -> Bool
isInTree t1@(Node root1 _) t2@(Node root2 subTrees2) =
  if root2 == root1
    then bfsForest [t1] `isInfixOf` bfsForest [t2]
    else or $ map (isInTree t1) subTrees2

-- Task 4 -----------------------------------------
toBTree :: Forest a -> BTree a
toBTree [] = BEmpty
toBTree ((Node root subTrs):rest) = BNode root (toBTree subTrs) (toBTree rest)

-- Task 5 -----------------------------------------
fromBTree :: BTree a -> Forest a
fromBTree BEmpty = []
fromBTree (BNode root l r) = (Node root (fromBTree l)) : (fromBTree r)

-- Task 6 -----------------------------------------
isSearch :: (Ord a) => BTree a -> Bool
isSearch BEmpty = True
isSearch (BNode root l r) =
  cmpr (<= root) l && cmpr (> root) r && isSearch l && isSearch r
  where
    cmpr _ BEmpty = True
    cmpr comparator (BNode h left right) =
      comparator h && cmpr comparator left && cmpr comparator right

-- Task 7  -----------------------------------------
elemSearch :: (Ord a) => BTree a -> a -> Bool
elemSearch bTree el
  | isSearch bTree = searchBinaryTree bTree el
  | otherwise = False

-- Task 8 ------------------------------------------
insSearch :: (Ord a) => BTree a -> a -> BTree a
insSearch bTree el
  | isSearch bTree = insertIntoBinaryTree bTree el
  | otherwise = BEmpty

-- Task 9 ------------------------------------------
delSearch :: (Ord a) => BTree a -> a -> BTree a
delSearch bTree el
  | (isSearch bTree) && not (elemSearch bTree el) = bTree
  | (isSearch bTree) && (elemSearch bTree el) = deleteFromBinaryTree bTree el
  | otherwise = BEmpty

-- Task 10 -----------------------------------------
sortList :: (Ord a) => [a] -> [a]
sortList list = inorderList (addListToTree BEmpty list)

-- Helpers -----------------------------------------
searchBinaryTree :: (Ord a) => BTree a -> a -> Bool
searchBinaryTree BEmpty _ = False
searchBinaryTree (BNode root l r) el
  | el == root = True
  | l == BEmpty && el <= root = False
  | el <= root = searchBinaryTree l el
  | r == BEmpty && el > root = False
  | el > root = searchBinaryTree r el
  | otherwise = False

insertIntoBinaryTree :: (Ord a) => BTree a -> a -> BTree a
insertIntoBinaryTree BEmpty el = BNode el BEmpty BEmpty
insertIntoBinaryTree (BNode root l r) el
  | el == root = BNode root (BNode el BEmpty BEmpty) r
  | el <= root = BNode root (insertIntoBinaryTree l el) r
  | el > root = BNode root l (insertIntoBinaryTree r el)
  | otherwise = BEmpty

deleteFromBinaryTree :: (Ord a) => BTree a -> a -> BTree a
deleteFromBinaryTree BEmpty _ = BEmpty
deleteFromBinaryTree node@(BNode root l r) el
  | el == root = deleteNode node el
  | el <= root = BNode root (deleteFromBinaryTree l el) r
  | el > root = BNode root l (deleteFromBinaryTree r el)
  | otherwise = BEmpty

deleteNode :: (Ord a) => BTree a -> a -> BTree a
deleteNode BEmpty _ = BEmpty
deleteNode (BNode _ l r) _
  | l == BEmpty = r
  | r == BEmpty = l
  | otherwise =
    let (newRoot, newL) = findMaxAndDelete l
     in BNode newRoot newL r

findMaxAndDelete :: (Ord a) => BTree a -> (a, BTree a)
findMaxAndDelete bTree =
  let m = fromJust (treeMaximum bTree)
   in (m, deleteFromBinaryTree bTree m)

treeMaximum :: (Ord a) => BTree a -> Maybe a
treeMaximum BEmpty = Nothing
treeMaximum (BNode root l r) = Just (maximum options)
  where
    options = catMaybes [Just root, treeMaximum l, treeMaximum r]

reverseInsert :: (Ord a) => a -> BTree a -> BTree a
reverseInsert el bTree = insSearch bTree el

addListToTree :: (Ord a) => BTree a -> [a] -> BTree a
addListToTree bTree arr = foldr reverseInsert bTree arr

inorderList :: (Ord a) => BTree a -> [a]
inorderList BEmpty = []
inorderList (BNode root l r) = inorderList l ++ (root : inorderList r)
