compareLastNames name1 name2 =
  case (compare lastName1 lastName2) of
    EQ -> compare firstName1 firstName2
    LT -> LT
    GT -> GT
  where
    lastName1 = snd name1
    lastName2 = snd name2
    firstName1 = fst name1
    firstName2 = fst name2

names =
  [ ("Ian", "Curtis")
  , ("Bernard", "Sumner")
  , ("Peter", "Hook")
  , ("Stephen", "Morris")
  ]