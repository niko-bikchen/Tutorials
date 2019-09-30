{-# OPTIONS_GHC -Wall #-}

type Graph = [[Int]]

g1 :: Graph
g1 = [[1, 4], [2], [3], [1], [2, 5], []]

gr3 :: Graph
gr3 = [[1], [2], [3], [1], [0, 3]]

adj :: Graph -> Int -> [Int]
adj graph node = graph !! node

nodes :: Graph -> [Int]
nodes graph = [0 .. ((length graph) - 1)]

edgeIn :: Graph -> (Int, Int) -> Bool
edgeIn graph edge = (snd edge) `elem` (graph !! fst edge)

edges :: Graph -> [(Int, Int)]
edges graph = [(x, y) | x <- (nodes graph), y <- graph !! x]

allWays :: Graph -> Int -> [[[Int]]]
allWays graph vertex = until condW (stepW graph) [[[vertex]]]

condW :: ([[[Int]]]) -> Bool
condW wss = null (head wss)

stepW :: Graph -> [[[Int]]] -> [[[Int]]]
stepW _ [] = error "allWays:stepW"
stepW graph wss@(wsn:_) =
  [t : w | w@(v:vs) <- wsn, notElem v vs, t <- graph !! v] : wss
