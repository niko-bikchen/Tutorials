myMap f [] = []
myMap f (x:xs) = (f x) : myMap f xs
