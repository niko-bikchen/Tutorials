{-# LANGUAGE FlexibleContexts #-}

-- I import qualified so that it's clear which
-- functions are from the parsec library:
import qualified Text.Parsec as Parsec

-- I am the choice and optional error message infix operator, used later:
import Text.Parsec ((<?>))

-- Imported so we can play with applicative things later.
-- not qualified as mostly infix operators we'll be using.
import Control.Applicative

-- Get the Identity monad from here:
import Control.Monad.Identity (Identity)

-- alias parseTest for more concise usage in my examples:
parse rule text = Parsec.parse rule "(source)" text

-- catching errors and succes
main :: IO ()
main = do
  let res = parse (Parsec.char 'H') "Hello"
  case res of
    Right v -> putStrLn "Nice"
    Left err -> putStrLn $ "Error: " ++ show err

myParser :: Parsec.Parsec String () (String, String)
myParser = do
  letters <- Parsec.many1 Parsec.letter
  Parsec.spaces
  digits <- Parsec.many1 Parsec.digit
  return (letters, digits)

mySeparator :: Parsec.Parsec String () ()
mySeparator = do
  Parsec.spaces
  Parsec.char ','
  Parsec.spaces

myPairs :: Parsec.Parsec String () [(String, String)]
myPairs =
  Parsec.many $ do
    pair <- myParser
    mySeparator
    return pair

myPairs2a :: Parsec.Parsec String () [(String, String)]
myPairs2a = Parsec.endBy myParser mySeparator

myPairs2b :: Parsec.Parsec String () [(String, String)]
myPairs2a = Parsec.sepBy myParser mySeparator
