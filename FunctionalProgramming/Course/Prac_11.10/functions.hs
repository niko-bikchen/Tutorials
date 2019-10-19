{-# OPTIONS_GHC -Wall #-}

type Term = [String]

type Expr = [Term]

breaks :: [a] -> [[[a]]]
breaks [] = error "Breaks"
breaks [v] = [[[v]]]
breaks (x:xs) =
  map (\(ys:yss) -> [x] : (ys : yss)) (breaks xs) ++
  map (\(ys:yss) -> (x : ys) : yss) (breaks xs)

build :: String -> [Expr]
build ds = concatMap breaks (breaks ds)

evalTerm :: Term -> Int
evalTerm = product . map read

showT :: Term -> String
showT fs = tail (concat (map ('*' :) fs))

showE :: Expr -> String
showE ts = tail (concat (map ('+' :) (map showT ts)))

eval :: Expr -> Int
eval ts = sum (map evalTerm ts)

find :: Int -> String -> [Expr]
find v ds = filter ((== v) . eval) $ build ds

findG :: Int -> String -> [String]
findG v ds = map showE (find v ds)
