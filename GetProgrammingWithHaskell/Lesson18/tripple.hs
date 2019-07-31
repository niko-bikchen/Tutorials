data Triple a =
  Triple a a a
  deriving (Show)

type Point3D = Triple Double

point :: Point3D
point = Triple 0.1 0.2 0.3

type FullName = Triple String

person :: FullName
person = Triple "Howard" "Phillips" "Lovecraft"

type Initials = Triple Char

initials :: Initials
initials = Triple 'H' 'P' 'L'

first :: Triple a -> a
first (Triple x _ _) = x

second :: Triple a -> a
second (Triple _ x _) = x

third :: Triple a -> a
third (Triple _ _ x) = x

toList :: Triple a -> [a]
toList (Triple x y z) = [x, y, z]

transform :: (a -> a) -> Triple a -> Triple a
transform func (Triple x y z) = Triple (func x) (func y) (func z)

tripleMap :: (Triple a -> b) -> [Triple a] -> [b]
tripleMap f [] = []
tripleMap f (x : xs) = (f x) : tripleMap f xs
