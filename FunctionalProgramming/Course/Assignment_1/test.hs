oddEven :: [Int] -> [Int]
oddEven xs =
  if length xs == 0
    then xs
    else if length xs == 1
           then xs
           else concat [[head (tail xs)], [head xs], oddEven (tail (tail xs))]
