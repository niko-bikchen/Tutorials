data Box a =
  Box a
  deriving (Show)

wrap :: a -> Box a
wrap x = Box x

unwrap :: Box a -> a
unwrap (Box x) = x

boxMap :: (Box a -> b) -> [Box a] -> [b]
boxMap f [] = []
boxMap f (x:xs) = (f x) : boxMap f xs
