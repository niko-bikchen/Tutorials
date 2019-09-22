{-# OPTIONS_GHC -Wall #-}

isPrefix :: String -> String -> Bool
isPrefix "" _ = True
isPrefix _ "" = False
isPrefix (x:xs) (y:ys) = x == y && isPrefix xs ys

suffixs :: String -> [String]
suffixs "" = [""]
suffixs xs = xs : suffixs (tail xs)

borders :: String -> [String]
borders "" = [""]
-- borders xs = filter (\x -> isPrefix x xs) (suffixs xs)
borders xs = filter (`isPrefix` xs) (suffixs xs)

maxBorder :: String -> String
-- maxBorder xs = (head . tail . borders) xs
maxBorder = head . tail . borders
