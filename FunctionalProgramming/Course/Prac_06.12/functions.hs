{-# OPTIONS_GHC -Wall #-}

import Text.ParserCombinators.Parsec

num :: Parser Int
num = do
  ds <- many digit
  return $ read ds

infOp :: String -> (a -> a -> a) -> Parser (a -> a -> a)
infOp x f = do
  _ <- string x
  return f

mulop :: Parser (Int -> Int -> Int)
mulop = infOp "*" (*)

paren :: Parser a -> Parser a
paren matcher = do
  _ <- char '('
  contents <- matcher
  _ <- char ')'
  return contents

addop :: Parser (Int -> Int -> Int)
addop = do
  op <- infOp "+" (+) <|> infOp "-" (-)
  return op

factor :: Parser Int
factor = do
  res <- num <|> paren num
  return res

term, expr :: Parser Int
term = chainl1 factor mulop

expr = chainl1 term addop

full :: Parser Int
full = do
  res <- expr
  eof
  return res
