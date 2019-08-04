{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text as T

aWord :: T.Text
aWord = "Cheese"

firstWord :: String
firstWord = "pessimism"

secondWord :: T.Text
secondWord = T.pack firstWord

thirdWord :: String
thirdWord = T.unpack secondWord

sampleInput :: T.Text
sampleInput = "this\nis\ninput"

main :: IO ()
main = do
  print aWord
