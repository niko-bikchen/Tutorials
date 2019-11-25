{-# OPTIONS_GHC -Wall #-}

module Bikchentaev04 where

type Graph = [[Int]]

-- Task 1 ------------------------------------
isGraph :: Graph -> Bool
isGraph [] = True
isGraph [[]] = True
isGraph (edges:graph) = (edgesOk edges) && (isGraph graph)

-- Task 2 ------------------------------------
isTournament :: Graph -> Bool
isTournament [] = True
isTournament [[]] = True
isTournament graph =
  checkIfTournament (length graphWithNodes) graphWithNodes graphWithNodes
  where
    graphWithNodes = zip [0 ..] graph

-- Task 3 ------------------------------------
isTransitive :: Graph -> Bool
isTransitive [] = True
isTransitive [[]] = True
isTransitive graph =
  foldl
    (&&)
    True
    [ (fst u_v, snd v_w) `elem` (allEdges graph)
    | u_v <- (allEdges graph)
    , v_w <- (allEdges graph)
    , (snd u_v == fst v_w)
    ]

-- Task 4 ------------------------------------
buildTransitive :: Graph -> Graph
buildTransitive [] = []
buildTransitive gr = map buildRes (map (allWays gr) (allNodes gr))

-- Task 5 ------------------------------------
longWay :: Graph -> Int -> Int -> Maybe [Int]
longWay [] _ _ = Nothing
longWay [[]] _ _ = Nothing
longWay graph from to
  | null (suitableWays graph from to) = Nothing
  | null (head (suitableWays graph from to)) = Nothing
  | otherwise = Just $ reverse $ head $ (suitableWays graph from to)

-- Task 6 ------------------------------------
gamiltonWay :: Graph -> Maybe [Int]
gamiltonWay [] = Just []
gamiltonWay [[]] = Just []
gamiltonWay graph
  | null (findGamiltonWay graph) = Nothing
  | null (head (findGamiltonWay graph)) = Nothing
  | otherwise = Just $ reverse $ head $ tail $ (findGamiltonWay graph)

-- Task 7 ------------------------------------
isAcyclic :: Graph -> Bool
isAcyclic [] = True
isAcyclic [[]] = True
isAcyclic graph =
  null
    [ way
    | node <- allNodes graph
    , ways <- allWays graph node
    , way <- ways
    , way /= [] && (length way >= 2) && ((head way) == (last way))
    ]

-- Task 8 ------------------------------------
topolSort :: Graph -> Maybe [Int]
topolSort [] = Just []
topolSort [[]] = Just []
topolSort graph
  | not (isAcyclic graph) = Nothing
  | otherwise =
    Just $
    topolSortHelper
      []
      [(node, adjst) | node <- allNodes graph, let adjst = adj graph node]
      0

-- Task 9 ------------------------------------
isTopolSort :: Graph -> [Int] -> Bool
isTopolSort [] [] = True
isTopolSort graph topSort
  | not (isAcyclic graph) = False
  | otherwise = topSort `elem` topolSortAll graph

--------------------- Test data -------
gr1, gr2, gr3, gr4 :: Graph
gr1 = [[1, 2, 3], [2, 3], [3, 4], [4], []]

gr2 = [[3, 4], [0, 3], [0, 1, 4], [2, 4], [1]]

gr3 = [[1], [2], [3], [1], [0, 3]]

gr4 = [[1, 2, 3], [1, 2, 3], [1, 2, 3], [1, 2, 3], [0, 1, 2, 3]]

--------------------- Helpers -------
edgesOk :: [Int] -> Bool
edgesOk [] = True
edgesOk (edge:edges) = (not (edge `elem` edges)) && (edgesOk edges)

listOfAbsentNodes :: Int -> Int -> [Int] -> [Int]
listOfAbsentNodes len nodeStart nodes =
  [ node
  | node <- [0 .. (len - 1)]
  , (not (node `elem` nodes)) && (node /= nodeStart)
  ]

checkIfEdgesExists :: Int -> [Int] -> [(Int, [Int])] -> Bool
checkIfEdgesExists _ [] _ = True
checkIfEdgesExists nodeStart (node:[]) graph =
  nodeStart `elem` (snd (graph !! node))
checkIfEdgesExists nodeStart (node:absentNodes) graph =
  nodeStart `elem` (snd (graph !! node)) &&
  (checkIfEdgesExists nodeStart absentNodes graph)

checkIfTournament :: Int -> [(Int, [Int])] -> [(Int, [Int])] -> Bool
checkIfTournament _ [] _ = False
checkIfTournament len ((nodeStart, nodesEnd):graph) copy
  | (len - 1) == nodeStart =
    checkIfEdgesExists nodeStart (listOfAbsentNodes len nodeStart nodesEnd) copy
  | otherwise =
    checkIfEdgesExists nodeStart (listOfAbsentNodes len nodeStart nodesEnd) copy &&
    (checkIfTournament len graph copy)

allNodes :: Graph -> [Int]
allNodes graph = [0 .. ((length graph) - 1)]

allEdges :: Graph -> [(Int, Int)]
allEdges graph = [(x, y) | x <- (allNodes graph), y <- graph !! x]

allWays :: Graph -> Int -> [[[Int]]]
allWays graph vertex = until condW (stepW graph) [[[vertex]]]

condW :: ([[[Int]]]) -> Bool
condW wss = null (head wss)

stepW :: Graph -> [[[Int]]] -> [[[Int]]]
stepW _ [] = error "allWays:stepW"
stepW graph wss@(wsn:_) =
  [t : w | w@(v:vs) <- wsn, notElem v vs, t <- graph !! v] : wss

sortInsert :: [Int] -> [Int]
sortInsert [] = []
sortInsert xs = foldl insert [] xs

insert :: [Int] -> Int -> [Int]
insert xs x = (filter (<= x) xs) ++ [x] ++ (filter (> x) xs)

set :: [Int] -> [Int]
set [] = []
set (x:xs) = x : (set (remove x xs))

remove :: Int -> [Int] -> [Int]
remove _ [] = []
remove x (y:ys)
  | x == y = remove x ys
  | otherwise = y : (remove x ys)

buildRes :: [[[Int]]] -> [Int]
buildRes ways = sortInsert (set (foldl1 (++) (diffWays ways)))

diffWays :: [[[Int]]] -> [[Int]]
diffWays ways = [x | y <- ways, g <- y, g /= [], let x = (init g)]

hasDuplicates :: [Int] -> Bool
hasDuplicates list = (length (set list)) == (length list)

suitableWays :: Graph -> Int -> Int -> [[Int]]
suitableWays graph from to =
  [way | ways <- allWays graph from, way <- ways, (head way) == to]

containsAllNodes :: [Int] -> [Int] -> Bool
containsAllNodes _ [] = True
containsAllNodes way (node:nodes) =
  node `elem` way && containsAllNodes way nodes

findGamiltonWay :: Graph -> [[Int]]
findGamiltonWay graph =
  [ way
  | node <- allNodes graph
  , ways <- allWays graph node
  , way <- ways
  , way /= [] &&
      (length way >= 2) &&
      ((head way) == (last way)) && (containsAllNodes way (allNodes graph))
  ]

adj :: Graph -> Int -> [Int]
adj graph node = graph !! node

topolSortHelper :: [Int] -> [(Int, [Int])] -> Int -> [Int]
topolSortHelper result nodes currentNode
  | containsAllNodes result [0 .. (length nodes) - 1] = reverse $ result
  | null (snd (nodes !! currentNode)) &&
      not ((fst (nodes !! currentNode)) `elem` result) =
    reverse $ (fst (nodes !! currentNode) : result) -- added this guard last
  | not ((fst (nodes !! currentNode)) `elem` result) =
    topolSortHelper
      (fst (nodes !! currentNode) : result)
      nodes
      (head (snd (nodes !! currentNode)))
  | otherwise = topolSortHelper result nodes (head (snd (nodes !! currentNode)))

topolSortAll :: Graph -> [[Int]]
topolSortAll [] = []
topolSortAll [[]] = [[]]
topolSortAll graph
  | not (isAcyclic graph) = [[]]
  | otherwise =
    [ topolSortHelper
      []
      [(node, adjst) | node <- allNodes graph, let adjst = adj graph node]
      count
    | count <- allNodes graph
    ]

unwrapMaybe :: Maybe a -> a
unwrapMaybe Nothing = error "Maybe.fromJust: Nothing"
unwrapMaybe (Just x) = x
