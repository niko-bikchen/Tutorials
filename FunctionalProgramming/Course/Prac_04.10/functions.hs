{-# OPTIONS_GHC -Wall #-}

extend :: Char -> [String] -> [[String]]
extend x [] = [[[x]]]
extend x (xs:xss) =
  let xsss = extend x xss
   in [(x : xs) : xss] ++ map (xs :) xsss

stepUp :: Char -> [[String]] -> [[String]]
-- stepUp c rs = concat $ map (extend c) rs
stepUp = concatMap . extend

unravels :: String -> [[String]]
unravels xs = foldr stepUp [[]] xs

up :: String -> Bool
up (x:(y:ys)) = (x <= y) && up (y : ys)
up _ = True

isGood :: [String] -> Bool
-- isGood rs = foldl (&&) True (map up rs)
-- isGood rs = and $ map up rs
isGood rs = all up rs

goodUpravel :: String -> [[String]]
goodUpravel xs = filter isGood (unravels xs)

supravel :: String -> [[String]]
supravel xs = filter ((== mn) . length) goods
  where
    goods = goodUpravel xs
    mn = minimum $ map length goods

permit :: Int -> String -> [String]
permit 0 _ = [[]]
permit n st = [x : y | x <- st, y <- permit (n - 1) st]

insert :: a -> [a] -> [[a]]
insert v [] = [[v]]
insert v (y:ys) = (v : y : ys) : (map (y :) (insert v ys))

change :: [a] -> [[a]]
change [] = [[]]
change (x:xs) = concat (map (insert x) (change xs))
-- :set +s
-- :unset +s
