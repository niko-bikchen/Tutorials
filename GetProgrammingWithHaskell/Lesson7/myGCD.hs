myGCD a b =
  if remainder == 0
    then b
    else myGCD b (remainder)
  where
    remainder = a `mod` b

myGCD2 a b = myGCD2 b (a `mod` b)
myGCD2 a 0 = a