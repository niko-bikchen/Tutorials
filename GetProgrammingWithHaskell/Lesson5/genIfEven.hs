ifEvenInc = ifEven (\n -> n + 1)

ifEvenDouble = ifEven (\n -> n + n)

ifEvenSquare = ifEven (\n -> n ^ 2)

ifEven myFunction n =
  if even n
    then myFunction n
    else n

genIfEvenX function = (\x -> ifEven function x)

genIfXEven x = (\function -> ifEven function x)
