{-# OPTIONS_GHC -Wall #-}

module Bikchentaev13 where

import Control.Monad (void)
import Text.ParserCombinators.Parsec

-- Task 1 -----------------------------------------
fullBrace :: Parser ()
fullBrace = do
  whitespace
  brace
  eof
  return ()

balance :: String -> Bool
balance str = either (const False) (const True) (parse fullBrace "" str)

brace :: Parser ()
brace = braceA <|> braceB <|> braceC <|> whitespace

braceA :: Parser ()
braceA = do
  symbol '('
  whitespace
  brace
  symbol ')'
  whitespace
  brace

braceB :: Parser ()
braceB = do
  symbol '{'
  whitespace
  brace
  symbol '}'
  whitespace
  brace

braceC :: Parser ()
braceC = do
  symbol '['
  whitespace
  brace
  symbol ']'
  whitespace
  brace

whitespace :: Parser ()
whitespace = void $ many $ oneOf " \n\t"

-- Task 2 ----------------------------------------- 
data Bexp
  = Bvalue Bool
  | Bvar Char
  | Not Bexp
  | And Bexp Bexp
  | Or Bexp Bexp
  deriving (Eq, Show)

fullBe :: Parser Bexp
fullBe = do
  exr <- bexp
  eof
  return exr

anBexp :: String -> Maybe Bexp
anBexp str =
  case (parse fullBe "" str) of
    Left _ -> Nothing
    Right ex -> Just ex

bdis :: Parser Bexp
bdis = bdisA <|> bdisB <|> bdisC <|> bdisD <|> bdisE

bdisA :: Parser Bexp
bdisA = do
  symbol '('
  exr <- bexp
  symbol ')'
  return exr

bdisB :: Parser Bexp
bdisB = do
  symbol '!'
  exr <- bdis
  return $ Not exr

bdisC :: Parser Bexp
bdisC = do
  var <- letter
  return $ Bvar var

bdisD :: Parser Bexp
bdisD = do
  void $ string "true"
  return $ Bvalue True

bdisE :: Parser Bexp
bdisE = do
  void $ string "false"
  return $ Bvalue False

bexp :: Parser Bexp
bexp = chainl1 bcon bexpA

bexpA :: Parser (Bexp -> Bexp -> Bexp)
bexpA = do
  symbol '|'
  return (Or)

bcon :: Parser Bexp
bcon = chainl1 bdis bconA

bconA :: Parser (Bexp -> Bexp -> Bexp)
bconA = do
  symbol '&'
  return (And)

-- Task 3 ----------------------------------------- 
type Name = String

type Attributes = [(String, String)]

data XML
  = Text String
  | Element Name Attributes [XML]
  deriving (Eq, Show)

fullXML :: Parser XML
fullXML = do
  whitespace
  el <- element
  whitespace
  eof
  return el

anXML :: String -> Maybe XML
anXML str =
  case (parse fullXML "" str) of
    Left _ -> Nothing
    Right res -> Just res

text :: Parser XML
text = do
  cont <- txt
  return $ Text cont

txt :: Parser String
txt = many $ noneOf "<>"

val :: Parser String
val = many $ noneOf "\""

fullValue :: Parser String
fullValue = do
  symbol '"'
  value <- val
  symbol '"'
  return value

name :: Parser String
name = do
  lt <- letter
  nm <- many nameA
  return $ lt : nm

nameA :: Parser Char
nameA = letter <|> digit <|> char '.' <|> char '-'

attrib :: Parser (String, String)
attrib = do
  whitespace
  nm <- name
  whitespace
  symbol '='
  whitespace
  vl <- fullValue
  return (nm, vl)

xml :: Parser XML
xml = element <|> text

element :: Parser XML
element = do
  symbol '<'
  nmB <- name <?> "Name Begin"
  attrs <- many attrib <?> "Attrib"
  symbol '>'
  xmls <- many xml <?> "XML"
  symbol '<'
  symbol '/'
  nmE <- name <?> "Name End"
  symbol '>'
  if nmE == nmB
    then return $ Element nmB attrs xmls
    else error "Closing and opening tag names mismatch"

----------------  ���� SPL  ------------   
data Value
  = I Int
  | B Bool
  deriving (Show, Eq)

data Exp
  = Var String -- �����
  | Const Value -- Task���
  | Op Exp Bop Exp -- Task��
  deriving (Show, Eq)

-- Task� (2-Task���) Task���
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
  | Ba
  | Bo
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

{- Task� 
  symbol = ';' | '{' | '}' | '(' | ')' 
  identif=  char {digit | char}
  keyword= "int" | "bool" | "if" | "while" | "for" | "else" | "true" | "false"
  iden   =  identif .... not "int" "bool" "if" "while" "for" "else" "true" "false"
  number = digit { digit }.
  mulOp  = "*" | "/".
  addOp  = "+" | "-".
  relOp  = "<" | "<=" | ">" | ">=" | "==" 
  disOp  = "&" 
  conOp  = "|"
  typev  = "int" | "bool" 
-}
iden :: Parser String
iden =
  try
    (do nm <- identif
        if (any
              (nm ==)
              ["int", "bool", "if", "while", "for", "else", "True", "False"])
          then unexpected ("reserved word " ++ show nm)
          else return nm)

oper :: String -> Bop -> Parser Bop
oper str bop = do
  _ <- string str
  return bop

mulOp :: Parser Bop
mulOp = (oper "*" Times) <|> (oper "/" Div)

disOp :: Parser Bop
disOp = (oper "&" Ba)

conOp :: Parser Bop
conOp = (oper "|" Bo)

-- Task��� �� "Task�" Task� � ����		
lexem :: Parser a -> Parser a
lexem p = do
  a <- p
  spaces
  return a

--   :type Op -----> Exp -> Bop -> Exp -> Exp 
--   :type flip Op -------> Bop -> Exp -> Exp -> Exp         
expOp :: Parser Bop -> Parser (Exp -> Exp -> Exp)
expOp p = do
  x <- lexem p
  return (flip Op x)

symbol :: Char -> Parser ()
symbol ch = lexem (char ch >> return ())

keyword :: String -> Parser ()
keyword st = try (lexem (string st >> notFollowedBy alphaNum))

typev :: Parser Type
typev =
  do keyword "int"
     return It
     <|> do
    keyword "bool"
    return Bt

-- Task 4 -----------------------------------------
identif :: Parser String
identif = do
  spaces
  a <- letter
  cs <- many (letter <|> digit)
  return (a : cs)

number :: Parser Int
number = do
  s <- string "-" <|> return []
  cs <- many1 digit
  return $ read (s ++ cs)

addOp :: Parser Bop
addOp = try (oper "+" Plus) <|> try (oper "-" Minus)

relOp :: Parser Bop
relOp =
  try (oper ">=" Ge) <|> try (oper ">" Gt) <|> try (oper "<=" Le) <|>
  try (oper "==" Eql) <|>
  try (oper "<" Lt)

{- Task 
  factor = '(' expr ')' | number | "true" | "false" | iden
  term   = factor { mulOp factor }
  relat  = term { addOp term }
  conj   = relat [relOp relat] 
  disj   = conj { conOp conj}   
  expr   = disj { disOp disj}
-}
factor :: Parser Exp
factor =
  do symbol '('
     x <- expr
     symbol ')'
     return x
     <|> do
    nm <- lexem number
    return (Const (I nm)) <|> do
      keyword "true"
      return (Const (B True)) <|> do
        keyword "false"
        return (Const (B False)) <|> do
          cs <- lexem iden
          return (Var cs) <?> "factor"

-- Task 5 -----------------------------------------
term :: Parser Exp
term = undefined

relat :: Parser Exp
relat = undefined

conj :: Parser Exp
conj = undefined

disj :: Parser Exp
disj = undefined

expr :: Parser Exp
expr = undefined

{- Task���
  stmt   = "for" forSt | "while" whileSt | "if" ifSt 
         | iden assSt | blockSt  
  forSt  = '(' stmt ';' expr ';' stmt ')' stmt 
  whileSt= '(' expr ')' stmt 
  ifSt   = '(' expr ')' stmt "else" stmt 
  assSt  = "++" | ":=" expr 
  blockSt= '{' {defin} listSt '}' 
  defin  = type iden ';'
  listSt = stmt {';' stmt}  
  program= stmt eos 
-}
stmt :: Parser Stmt
stmt =
  do keyword "for"
     forSt
     <|> do
    keyword "while"
    whileSt <|> do
      keyword "if"
      ifSt <|> do
        var <- lexem iden
        assignSt var <|> blockSt <?> "statement"

-- Task 6 -----------------------------------------
forSt :: Parser Stmt
forSt = undefined

whileSt :: Parser Stmt
whileSt = undefined

ifSt :: Parser Stmt
ifSt = undefined

assignSt :: String -> Parser Stmt
assignSt = undefined

blockSt :: Parser Stmt
blockSt = undefined

---------------------------------------------	
-- Task� Task�
---------------------------------------------				
program :: Parser Stmt
program = do
  spaces
  r <- stmt
  eof
  return r

parseSPL :: String -> Either ParseError Program
parseSPL s = parse program "" s

---------------------------------------------
--- ���� ��� Task����
--------------------------------------------- 
casablanca :: String
casablanca =
  "<film title=\"Casablanca\">\n  <director>Michael Curtiz</director>\n  <year>1942\
    \</year>\n</film>\n\n\n"

casablancaParsed :: XML
casablancaParsed =
  Element
    "film"
    [("title", "Casablanca")]
    [ Text "\n  "
    , Element "director" [] [Text "Michael Curtiz"]
    , Text "\n  "
    , Element "year" [] [Text "1942"]
    , Text "\n"
    ]

power :: String
power =
  "{ int b; int e; int out; b := 6; e := 5; out:= 1;\
   \  for (i:=0; i<e; i++) out := out*b   \
   \}"

powerAST :: Program
powerAST =
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

squareRoot :: String
squareRoot =
  "{int a; int b; a := 317; b := 0;\
   \  {bool c; c:=true; while(c) {b++; c:= a >= b*b}};\
   \  b := b-1\
   \ }"

squareRootAST :: Program
squareRootAST =
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
