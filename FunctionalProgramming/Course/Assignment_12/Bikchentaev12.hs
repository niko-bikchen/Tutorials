{-# OPTIONS_GHC -Wall #-}

module Bikchentaev12 where

import Data.Maybe

data Value
  = I Int
  | B Bool
  deriving (Show, Eq)

data Exp
  = Var String
  | Const Value
  | Op Exp Bop Exp
  deriving (Show, Eq)

data Bop
  = Plus
  | Minus
  | Times
  | Div
  | Gt
  | Ge
  | Lt
  | Le
  | Eql
  | And
  | Or
  deriving (Show, Eq)

data Stmt
  = Assign String Exp
  | Incr String
  | If Exp Stmt Stmt
  | While Exp Stmt
  | For Stmt Exp Stmt Stmt
  | Block [(String, Type)] [Stmt]
  deriving (Show, Eq)

data Type
  = It
  | Bt
  deriving (Show, Eq)

type Program = Stmt

type StateW = [(String, Value)]

type VarEnv = [(String, Type)]

-- Task 1 -----------------------------------------
getValue :: StateW -> String -> Value
getValue vars var = fromJust $ lookup var vars

updValue :: StateW -> String -> Value -> StateW
updValue [] _ _ = []
updValue (pair@(var_name, _):vars) var new_val
  | var_name == var = (var_name, new_val) : vars
  | otherwise = pair : (updValue vars var new_val)

-- Task 2 ----------------------------------------- 
evExp :: StateW -> Exp -> Value
evExp vars (Var name) = getValue vars name
evExp _ (Const val) = val
evExp vars (Op exp1 binary exp2) =
  case binary of
    Plus ->
      I $ (getIntFromVal (evExp vars exp1)) + (getIntFromVal (evExp vars exp2))
    Minus ->
      I $ (getIntFromVal (evExp vars exp1)) - (getIntFromVal (evExp vars exp2))
    Times ->
      I $ (getIntFromVal (evExp vars exp1)) * (getIntFromVal (evExp vars exp2))
    Div ->
      I $
      (getIntFromVal (evExp vars exp1)) `div` (getIntFromVal (evExp vars exp2))
    Gt ->
      B $ (getIntFromVal (evExp vars exp1)) > (getIntFromVal (evExp vars exp2))
    Ge ->
      B $ (getIntFromVal (evExp vars exp1)) >= (getIntFromVal (evExp vars exp2))
    Lt ->
      B $ (getIntFromVal (evExp vars exp1)) < (getIntFromVal (evExp vars exp2))
    Le ->
      B $ (getIntFromVal (evExp vars exp1)) <= (getIntFromVal (evExp vars exp2))
    Eql -> B $ (evExp vars exp1) == (evExp vars exp2)
    And ->
      if ((getBoolFromVal (evExp vars exp1)) == True) &&
         ((getBoolFromVal (evExp vars exp2)) == True)
        then B True
        else B False
    Or ->
      if ((getBoolFromVal (evExp vars exp1)) == False) &&
         ((getBoolFromVal (evExp vars exp2)) == False)
        then B False
        else B True

getIntFromVal :: Value -> Int
getIntFromVal (I num) = num
getIntFromVal _ = error "Invalid input"

getBoolFromVal :: Value -> Bool
getBoolFromVal (B bool) = bool
getBoolFromVal _ = error "Invalid input"

-- Task 3 -----------------------------------------
evStmt :: StateW -> Stmt -> StateW
evStmt vars statement =
  case statement of
    (Assign var_name expression) ->
      updValue vars var_name (evExp vars expression)
    (Incr var_name) ->
      updValue vars var_name (I ((getIntFromVal (getValue vars var_name)) + 1))
    (If expression st1 st2) ->
      if (getBoolFromVal (evExp vars expression))
        then evStmt vars st1
        else evStmt vars st2
    (While expression st) ->
      if (getBoolFromVal (evExp vars expression))
        then evStmt vars st
        else vars
    (For st_init bool_expr step_st block_st) ->
      (interpretFor (evStmt vars st_init) bool_expr step_st block_st)
    (Block block_vars block_statements) ->
      foldl
        evStmt
        ([ if var_type == Bt
           then (var_name, B False)
           else (var_name, I 0)
         | (var_name, var_type) <- block_vars
         ] ++
         vars)
        block_statements

interpretFor :: StateW -> Exp -> Stmt -> Stmt -> StateW
interpretFor vars bool_expr step_st block_st
  | (getBoolFromVal (evExp vars bool_expr)) == True =
    interpretFor (evStmt evSt step_st) bool_expr step_st block_st
  | otherwise = drop 1 vars
  where
    evSt = evStmt vars block_st

-- Task 4 -----------------------------------------
evProgram :: Program -> StateW
evProgram prog = evStmt [] prog

-- Task 5 -----------------------------------------
iswfOp :: Bop -> [Type] -> Maybe Type
iswfOp binary types
  | (binary == Plus || binary == Minus || binary == Times || binary == Div) &&
      length types == 2 && ((head types) == It && (last types) == It) = Just It
  | (binary == Eql || binary == And || binary == Or) &&
      length types == 2 &&
      (((head types) == It && (last types) == It) ||
       ((head types) == Bt && (last types) == Bt)) = Just Bt
  | length types == 2 && ((head types) == It && (last types) == It) = Just Bt
  | otherwise = Nothing

-- Task 6 -----------------------------------------
iswfExp :: Exp -> VarEnv -> Maybe Type
iswfExp (Var name) vars = lookup name vars
iswfExp (Const val) _
  | val == B False || val == B True = Just Bt
  | otherwise = Just It
iswfExp (Op exp1 binary exp2) vars =
  iswfOp binary [fromJust (iswfExp exp1 vars), fromJust (iswfExp exp2 vars)]

-- Task 7 -----------------------------------------
iswfStmt :: Stmt -> VarEnv -> Bool
iswfStmt statement vars =
  case statement of
    (Assign var_name expression) ->
      case iswfExp expression vars of
        Just t -> lookup var_name vars == Just t
        _ -> False
    (Incr var_name) -> lookup var_name vars == Just It
    (If expression st1 st2) ->
      case iswfExp expression vars of
        Just t ->
          (Just t == Just Bt) && (iswfStmt st1 vars) && (iswfStmt st2 vars)
        _ -> False
    (While expression st) ->
      case iswfExp expression vars of
        Just t -> (Just t == Just Bt) && (iswfStmt st vars)
        _ -> False
    (For st_init bool_expr step_st block_st) ->
      case iswfExp bool_expr vars of
        Just t ->
          (Just t == Just Bt) &&
          (iswfStmt st_init vars) &&
          (iswfStmt step_st vars) && (iswfStmt block_st vars)
        _ -> False
    (Block block_vars block_statements) ->
      and (map ((flip iswfStmt) (block_vars ++ vars)) block_statements)

--------------------------------
iswfProgram :: Program -> Bool
iswfProgram st@(Block _ _) = iswfStmt st []
iswfProgram _ = False

-- Task�� -------------------------------------------
{- Task���� Task�� b(6) � Task� e(5) � Task out 

   { int b; int e; int out;  
     b := 6; e := 5; out:= 1;
	 { int i; 
       for (i:=0; i<e; i++) out := out*b   
	 }  
   }
-}
power :: Program
power =
  Block
    [("b", It), ("e", It), ("out", It)]
    [ Assign "b" (Const (I 6))
    , Assign "e" (Const (I 5))
    , Assign "out" (Const (I 1))
    , Block
        [("i", It)]
        [ For
            (Assign "i" (Const (I 0)))
            (Op (Var "i") Lt (Var "e"))
            (Incr "i")
            (Assign "out" (Op (Var "out") Times (Var "b")))
        ]
    ]

{- Task���� Task Task�� ����� Task����� 
   � Task�� ����� a (317) � Task b 

   {int a; int b; 
    a := 317; b := 0;
	{bool c; c:=true; 
	         while(c) {b++; c:= a >= b*b}
	};
    b := b-1
   } 	
-}
squareRoot :: Program
squareRoot =
  Block
    [("a", It), ("b", It)]
    [ Assign "a" (Const (I 317))
    , Assign "b" (Const (I 0))
    , Block
        [("c", Bt)]
        [ Assign "c" (Const (B True))
        , While
            (Var "c")
            (Block
               []
               [ (Incr "b")
               , Assign "c" (Op (Var "a") Ge (Op (Var "b") Times (Var "b")))
               ])
        ]
    , Assign "b" (Op (Var "b") Minus (Const (I 1)))
    ]

{- Task�� Task�� 12-�� ����� ԳTask� � Task out
  {int in; int out; in := 121; 
     {int f0; int f1; int c; f0 := 1; f1 := 1;
      if(in == 0) then out := f0 else 
      if (in == 1) then out := f1 else 
        for (c := 2; c <= in; c++) {
         out := f0 + f1; f0 := f1; f1 := out
        }
	 } 	
  }
-}
fibonacci :: Program
fibonacci =
  Block
    [("in", It), ("out", It)]
    [ Assign "in" (Const (I 12))
    , Block
        [("f0", It), ("f1", It), ("c", It)]
        [ Assign "f0" (Const (I 1))
        , Assign "f1" (Const (I 1))
        , If
            (Op (Var "in") Eql (Const (I 0)))
            (Assign "out" (Var "f0"))
            (If
               (Op (Var "in") Eql (Const (I 1)))
               (Assign "out" (Var "f1"))
               (For
                  (Assign "c" (Const (I 1)))
                  (Op (Var "c") Lt (Var "in"))
                  (Incr "c")
                  (Block
                     []
                     [ Assign "out" (Op (Var "f0") Plus (Var "f1"))
                     , Assign "f0" (Var "f1")
                     , Assign "f1" (Var "out")
                     ])))
        ]
    ]
