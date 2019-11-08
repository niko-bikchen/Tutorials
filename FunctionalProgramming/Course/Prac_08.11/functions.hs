{-# OPTIONS_GHC -Wall #-}

data Expr
  = Lit Int
  | Op Expr Bop Expr
  deriving (Eq, Show)

data Bop
  = Add
  | Sub
  | Mul
  deriving (Eq, Show)

build :: String -> Expr
build exprStr = first (foldl bf [] (words exprStr))

buildS :: String -> Maybe Expr
buildS exprStr = firstS (foldl bfS (Just []) (words exprStr))

bf :: [Expr] -> String -> [Expr]
bf (x:y:ys) "*" = (Op y Mul x) : ys
bf (x:y:ys) "+" = (Op y Add x) : ys
bf (x:y:ys) "-" = (Op y Sub x) : ys
bf xs nmb
  | isInt nmb = (Lit (read nmb)) : xs
  | otherwise = error "Cannot convert input to a number."

bfS :: Maybe [Expr] -> String -> Maybe [Expr]
bfS (Just (x:y:ys)) "*" = Just $ (Op y Mul x) : ys
bfS (Just (x:y:ys)) "+" = Just $ (Op y Add x) : ys
bfS (Just (x:y:ys)) "-" = Just $ (Op y Sub x) : ys
bfS (Just xs) nmb
  | isInt nmb = Just $ (Lit (read nmb)) : xs
  | otherwise = Nothing
bfS _ _ = Nothing

eval :: Expr -> Int
eval (Lit v) = v
eval (Op e1 op e2) = evalBop op (eval e1) (eval e2)

evalBop :: Bop -> Int -> Int -> Int
evalBop Add v1 v2 = v1 + v2
evalBop Sub v1 v2 = v1 - v2
evalBop Mul v1 v2 = v1 * v2

solve :: String -> Int
solve = eval . build

solveS :: String -> Maybe Int
solveS st =
  case buildS st of
    (Just e) -> Just (eval e)
    Nothing -> Nothing

isInt :: String -> Bool
isInt = null . filter (`notElem` "0123456789")

first :: [Expr] -> Expr
first [e] = e
first _ =
  error "Function 'bf' returned a list which contains more than one value."

firstS :: Maybe [Expr] -> Maybe Expr
firstS (Just [e]) = Just e
firstS _ = Nothing
