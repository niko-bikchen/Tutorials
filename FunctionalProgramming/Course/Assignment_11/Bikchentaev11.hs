{-# OPTIONS_GHC -Wall #-}

module Bikchentaev11 where

import Data.Char (isLetter, isLower)

data BExp
  = Bvalue Bool
  | Bvar Char
  | Not BExp
  | And BExp BExp
  | Or BExp BExp
  deriving (Eq, Ord, Show)

type Env = [(Char, Bool)]

type NodeId = Int

type BDDNode = (NodeId, (Char, NodeId, NodeId))

type BDD = (NodeId, [BDDNode])

-- Task 1 -----------------------------------------
checkSat :: BDD -> Env -> Bool
checkSat (node_id, nodes) env = checkSat' (node_id, (findVal node_id nodes))
  where
    checkSat' (0, _) = False
    checkSat' (1, _) = True
    checkSat' (_, (var_name, l, r))
      | findVal var_name env = checkSat' (r, (findVal r nodes))
      | otherwise = checkSat' (l, (findVal l nodes))

findVal :: Eq a => a -> [(a, b)] -> b
findVal key tups = snd $ head $ filter (\(a, _) -> a == key) tups

-- Task 2 -----------------------------------------
sat :: BDD -> [[(Char, Bool)]]
sat (node_id, nodes) = sat' (node_id, (findVal node_id nodes)) []
  where
    sat' (0, _) _ = []
    sat' (1, _) aggregator = [aggregator]
    sat' (_, (var_name, l, r)) aggregator =
      sat' (l, (findVal l nodes)) ((var_name, False) : aggregator) ++
      sat' (r, (findVal r nodes)) ((var_name, True) : aggregator)

-- Task 3 -----------------------------------------
simplify :: BExp -> BExp
simplify (Not (Bvalue b)) = Bvalue (not b)
simplify (Or (Bvalue a) (Bvalue b)) = Bvalue (a || b)
simplify (And (Bvalue a) (Bvalue b)) = Bvalue (a && b)
simplify a = a

-- Task 4 -----------------------------------------
restrict :: BExp -> Char -> Bool -> BExp
restrict expr@(Bvar var) var_name bool_const
  | var == var_name = Bvalue bool_const
  | otherwise = expr
restrict expr@(Bvalue _) _ _ = expr
restrict (Not expr) var_name bool_const =
  simplify (Not $ restrict expr var_name bool_const)
restrict (Or expr1 expr2) var_name bool_const =
  simplify
    (Or
       (restrict expr1 var_name bool_const)
       (restrict expr2 var_name bool_const))
restrict (And expr1 expr2) var_name bool_const =
  simplify
    (And
       (restrict expr1 var_name bool_const)
       (restrict expr2 var_name bool_const))

-- Task 5 -----------------------------------------
buildBDD :: BExp -> [Char] -> BDD
buildBDD e xs = buildBDD' e 2 xs

buildBDD' :: BExp -> NodeId -> [Char] -> BDD
buildBDD' expr _ []
  | expr == Bvalue True = (1, [])
  | expr == Bvalue False = (0, [])
buildBDD' expr node_id (var:vars) = (node_id, currentNode : lt ++ rt)
  where
    (l, lt) = buildBDD' (restrict expr var False) (2 * node_id) vars
    (r, rt) = buildBDD' (restrict expr var True) (2 * node_id + 1) vars
    currentNode = (node_id, (var, l, r))

-- Task 6 -----------------------------------------
buildROBDD :: BExp -> [Char] -> BDD
buildROBDD e xs = buildROBDD' e 2 xs []

buildROBDD' :: BExp -> NodeId -> [Char] -> [BDDNode] -> BDD
buildROBDD' (Bvalue b) _ _ nodes = (fromEnum b, nodes)
buildROBDD' expr node_id (var:vars) nodes
  | l == r = (l, lt)
  | otherwise =
    maybe
      (node_id, (node_id, (var, l, r)) : rt)
      (\n -> (n, rt))
      (revLookUp (var, l, r) rt)
  where
    currentNode1 = restrict expr var False
    currentNode2 = restrict expr var True
    (l, lt) = buildROBDD' currentNode1 (2 * node_id) vars nodes
    (r, rt) = buildROBDD' currentNode2 (2 * node_id + 1) vars lt

revLookUp :: Eq a => a -> [(b, a)] -> Maybe b
revLookUp i t = lookup i [(v, k) | (k, v) <- t]

-- Task 7 -----------------------------------------
fullBexp :: String -> Maybe BExp
fullBexp str =
  case bexp str of
    Just (expr, stringo) ->
      if stringo == ""
        then Just expr
        else Nothing
    _ -> Nothing

bexp :: String -> Maybe (BExp, String)
bexp str =
  case bcon str of
    Just (expr, rest) -> manyCon (expr, rest)
    _ -> Nothing

bcon :: String -> Maybe (BExp, String)
bcon str =
  case bdis str of
    Just (expr, rest) -> manyDis (expr, rest)
    _ -> Nothing

manyCon :: (BExp, String) -> Maybe (BExp, String)
manyCon (expres, sym:str) =
  case sym of
    '|' ->
      case bcon str of
        Just (expr, rest) -> manyCon (Or expres expr, rest)
        _ -> Nothing
    _ -> Just (expres, sym : str)
manyCon (expres, "") = Just (expres, "")

bdis :: String -> Maybe (BExp, String)
bdis [] = Nothing
bdis (sym:str) =
  case bsym sym of
    True -> Just (Bvar sym, str)
    False ->
      case sym of
        '(' ->
          case bexp str of
            Just (expr, ')':rest) -> Just (expr, rest)
            _ -> Nothing
        '!' ->
          case bdis str of
            Just (expr, rest) -> Just (Not expr, rest)
            _ -> Nothing
        'T' -> Just (Bvalue True, str)
        'F' -> Just (Bvalue False, str)
        _ -> Nothing

manyDis :: (BExp, String) -> Maybe (BExp, String)
manyDis (expres, sym:str) =
  case sym of
    '&' ->
      case bdis str of
        Just (expr, rest) -> manyDis (And expres expr, rest)
        _ -> Nothing
    _ -> Just (expres, sym : str)
manyDis (expres, "") = Just (expres, "")

bsym :: Char -> Bool
bsym sym = (isLetter sym) && (isLower sym)

------------------------------------------------------
bs1, bs2, bs3, bs4, bs5, bs6, bs7, bs8, bs9 :: String
bs1 = "F"

bs2 = "!(x&(F|y))"

bs3 = "u&T"

bs4 = "d&(x|!y)"

bs5 = "!(d&(x|!y))"

bs6 = "u&x|y&z"

bs7 = "!y|(x|!e)"

bs8 = "u|!u"

bs9 = "z&(y|!y&x)"

b1, b2, b3, b4, b5, b6, b7, b8, b9 :: BExp
b1 = Bvalue False

b2 = Not (And (Bvar 'x') (Or (Bvalue False) (Bvar 'y')))

b3 = And (Bvar 'u') (Bvalue True)

b4 = And (Bvar 'd') (Or (Bvar 'x') (Not (Bvar 'y')))

b5 = Not (And (Bvar 'd') (Or (Bvar 'x') (Not (Bvar 'y'))))

b6 = Or (And (Bvar 'u') (Bvar 'x')) (And (Bvar 'y') (Bvar 'z'))

b7 = Or (Not (Bvar 'y')) (Or (Bvar 'x') (Not (Bvar 'e')))

b8 = Or (Bvar 'u') (Not (Bvar 'u'))

b9 = And (Bvar 'z') (Or (Bvar 'y') (And (Not (Bvar 'y')) (Bvar 'x')))

bdd1, bdd2, bdd3, bdd4, bdd5, bdd6, bdd7, bdd8, bdd9 :: BDD
bdd1 = (0, [])

bdd2 = (2, [(2, ('x', 4, 5)), (4, ('y', 1, 1)), (5, ('y', 1, 0))])

bdd3 = (5, [(5, ('u', 0, 1))])

bdd4 =
  ( 2
  , [ (2, ('x', 4, 5))
    , (4, ('y', 8, 9))
    , (8, ('d', 0, 1))
    , (9, ('d', 0, 0))
    , (5, ('y', 10, 11))
    , (10, ('d', 0, 1))
    , (11, ('d', 0, 1))
    ])

bdd5 =
  ( 3
  , [ (4, ('y', 8, 9))
    , (3, ('x', 4, 5))
    , (8, ('d', 1, 0))
    , (9, ('d', 1, 1))
    , (5, ('y', 10, 11))
    , (10, ('d', 1, 0))
    , (11, ('d', 1, 0))
    ])

bdd6 =
  ( 2
  , [ (2, ('u', 4, 5))
    , (4, ('x', 8, 9))
    , (8, ('y', 16, 17))
    , (16, ('z', 0, 0))
    , (17, ('z', 0, 1))
    , (9, ('y', 18, 19))
    , (18, ('z', 0, 0))
    , (19, ('z', 0, 1))
    , (5, ('x', 10, 11))
    , (10, ('y', 20, 21))
    , (20, ('z', 0, 0))
    , (21, ('z', 0, 1))
    , (11, ('y', 22, 23))
    , (22, ('z', 1, 1))
    , (23, ('z', 1, 1))
    ])

bdd7 =
  ( 6
  , [ (6, ('x', 4, 5))
    , (4, ('y', 8, 9))
    , (8, ('e', 1, 1))
    , (9, ('e', 1, 0))
    , (5, ('y', 10, 11))
    , (10, ('e', 1, 1))
    , (11, ('e', 1, 1))
    ])

bdd8 = (2, [(2, ('u', 1, 1))])

bdd9 =
  ( 2
  , [ (2, ('x', 4, 5))
    , (4, ('y', 8, 9))
    , (8, ('z', 0, 0))
    , (9, ('z', 0, 1))
    , (5, ('y', 10, 11))
    , (10, ('z', 0, 1))
    , (11, ('z', 0, 1))
    ])
