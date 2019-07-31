myRemove test [] = []
myRemove test (x:xs) =
  if test x
    then myRemove test xs
    else x : myRemove test xs
