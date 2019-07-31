addAnA [] = []
addAnA (x:xs) = ("a " ++ x) : addAnA xs
