{-# OPTIONS_GHC -Wall #-}

c, b :: String -> Maybe String
c ('d':st1) =
  case c st1 of
    Just ('d':st2) -> Just st2
    _ -> Nothing
c ('a':st1) =
  case b st1 of
    Just ('a':st2) -> Just st2
    _ -> Nothing
c _ = Nothing

b ('e':st1) = b st1
b st1 = Just st1
