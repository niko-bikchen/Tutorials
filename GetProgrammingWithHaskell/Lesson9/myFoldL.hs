myFoldL :: (a -> a -> a) -> a -> [a] -> a
myFoldL f init [] = init
myFoldL f init (x:xs) = myFoldL f (f init x) xs

myFoldR f init [] = init
myFoldR f init (x:xs) = f x (myFoldR f init xs)
