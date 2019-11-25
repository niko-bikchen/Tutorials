{-# OPTIONS_GHC -Wall #-}

module Bikchentaev10 where

import Data.Char (isDigit, isLetter, isSpace)

type Name = String

type Attributes = [(String, String)]

data XML
  = Text String
  | Element Name Attributes [XML]
  deriving (Eq, Show)

-- Task 1 -----------------------------------------
spaces :: String -> String
spaces "" = ""
spaces str@(sym:rest) =
  case isSpace sym of
    True -> spaces rest
    False -> str

-- Task 2 ----------------------------------------- 
manyT, value, manyN :: String -> (String, String)
manyT str = prefixFinder ("", "") sT str

sT :: Char -> Bool
sT chr = chr /= '<' && chr /= '>'

value "" = ("", "")
value str = prefixFinder ("", "") cV str

cV :: Char -> Bool
cV chr = chr /= '"'

manyN "" = ("", "")
manyN str = prefixFinder ("", "") sN str

sN :: Char -> Bool
sN chr = (isLetter chr) || (isDigit chr) || (chr == '.') || (chr == '-')

prefixFinder :: (String, String) -> (Char -> Bool) -> String -> (String, String)
prefixFinder result _ "" = result
prefixFinder (left, _) matcher str@(sym:rest) =
  case matcher sym of
    True -> prefixFinder ((left ++ [sym]), "") matcher rest
    False -> (left, str)

-- Task 3 -----------------------------------------
name, text, fullValue :: String -> Maybe (String, String)
name str =
  case manyN str of
    ("", _) -> Nothing
    (match, rest) -> Just (match, rest)

text str =
  case manyT str of
    ("", _) -> Nothing
    (match, rest) -> Just (match, rest)

fullValue "" = Nothing
fullValue ('"':rest) =
  case value rest of
    (match, ('"':remains)) -> Just (match, remains)
    _ -> Nothing
fullValue _ = Nothing

-- Task 4 -----------------------------------------
attrib :: String -> Maybe ((String, String), String)
attrib str =
  case name (spaces str) of
    Just (attrName, rest) ->
      case value rest of
        (eq, other) ->
          case spaces eq of
            ('=':_) ->
              case fullValue other of
                Just (attrVal, remains) -> Just ((attrName, attrVal), remains)
                _ -> Nothing
            _ -> Nothing
    _ -> Nothing

manyAtt :: String -> Maybe (Attributes, String)
manyAtt string = manyAttHelper [] string

manyAttHelper :: Attributes -> String -> Maybe (Attributes, String)
manyAttHelper attrs string =
  case attrib string of
    Just (attr, rest) -> manyAttHelper (attrs ++ [attr]) rest
    _ -> Just (attrs, string)

-- Task 5 -----------------------------------------
begTag :: String -> Maybe ((String, Attributes), String)
begTag string =
  case spaces string of
    ('<':rest) ->
      case name rest of
        Just (nm, other) ->
          case spaces other of
            ('=':_) -> Nothing
            _ ->
              case manyAtt other of
                Just (attrs, remains) ->
                  Just ((nm, attrs), tail (spaces remains))
                _ -> Nothing
        _ -> Nothing
    _ -> Nothing

endTag :: String -> Maybe (String, String)
endTag string =
  case spaces string of
    ('<':'/':other) ->
      case name other of
        Just (nm, remains) ->
          case spaces remains of
            '>':remainders -> Just (nm, remainders)
            _ -> Nothing
        _ -> Nothing
    _ -> Nothing

-- Task 6 -----------------------------------------
element :: String -> Maybe (XML, String)
element string =
  case spaces string of
    str ->
      case begTag str of
        Just ((stTag, attrs), rest) ->
          case text rest of
            Just (txt, other) ->
              case endTag other of
                Just (edTag, remains) ->
                  if edTag == stTag
                    then Just (Element stTag attrs [Text txt], remains)
                    else Nothing
                _ -> Nothing
            _ ->
              case endTag rest of
                Just (edTag, other) ->
                  if stTag == edTag
                    then Just (Element stTag attrs [Text ""], other)
                    else Nothing
                _ -> element rest
        _ -> Nothing

xml :: String -> Maybe (XML, String)
xml = undefined

manyXML :: String -> Maybe ([XML], String)
manyXML = undefined

-- Task 7 -----------------------------------------
fullXML :: String -> Maybe XML
fullXML = undefined

--fullXML  = case element (spaces s) of  
--  Just (xm,s1) -> if null (spaces s1) then Just xm else Nothing 
--  Nothing      -> Nothing  
stst1, stst2, stst3 :: String
stst1 = "<a>A</a>"

stst2 = "<a x=\"1\"><b>A</b><b>B</b></a>"

stst3 =
  "<a>\
      \<b>\
        \<c att=\"att1\">text1</c>\
        \<c att=\"att2\">text2</c>\
      \</b>\
      \<b>\
        \<c att=\"att3\">text3</c>\
        \<d>text4</d>\
      \</b>\
    \</a>"

x1, x2, x3 :: XML
x1 = Element "a" [] [Text "A"]

x2 =
  Element
    "a"
    [("x", "1")]
    [Element "b" [] [Text "A"], Element "b" [] [Text "B"]]

x3 =
  Element
    "a"
    []
    [ Element
        "b"
        []
        [ Element "c" [("att", "att1")] [Text "text1"]
        , Element "c" [("att", "att2")] [Text "text2"]
        ]
    , Element
        "b"
        []
        [ Element "c" [("att", "att3")] [Text "text3"]
        , Element "d" [] [Text "text4"]
        ]
    ]

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
