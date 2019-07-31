isPalindrome list = length (filter (\x -> not x) results) == 0
  where
    listWithoutSpaces = filter (\x -> not (x == ' ')) list
    reverseListWithoutSpaces = reverse listWithoutSpaces
    results = map (\x -> x `elem` reverseListWithoutSpaces) listWithoutSpaces
