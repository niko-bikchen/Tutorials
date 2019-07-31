myTake _ [] = []
myTake 0 _ = []
myTake n (first:rest) = first : myTake n - 1 rest
