ifEvenInc n =
  if even n
    then n + 1
    else n

ifEvenDouble n =
  if even n
    then n + n
    else n

ifEvenSquare n =
  if even n
    then n ^ 2
    else n

ifEven myFunction n =
  if even n
    then myFunction n
    else n

inc n = n + 1

double n = n + n

square n = n ^ 2

ifEvenIncNew n = ifEven inc n

ifEvenDoubleNew n = ifEven double n

ifEvenSquareNew n = ifEven square n

ifEvenCube n = ifEven (\x -> x^3) n