module Palindrome
  ( isPalindrome
  ) where

import Data.Char (isPunctuation, isSpace, toLower)
import qualified Data.Text as T

stripWhiteSpace :: T.Text -> T.Text
stripWhiteSpace text = T.dropAround isSpace text

stripPunctuation :: T.Text -> T.Text
stripPunctuation text = T.dropAround isPunctuation text

toLowerCase :: T.Text -> T.Text
toLowerCase text = T.toLower text

preprocess :: T.Text -> T.Text
preprocess = stripWhiteSpace . stripPunctuation . toLowerCase

isPalindrome :: T.Text -> Bool
isPalindrome text = cleanText == T.reverse cleanText
  where
    cleanText = preprocess text
