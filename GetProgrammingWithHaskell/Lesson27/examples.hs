import qualified Data.Map as Map

successfulRequest :: Maybe Int
successfulRequest = Just 6

failedRequest :: Maybe Int
failedRequest = Nothing

incMaybe :: Maybe Int -> Maybe Int
incMaybe (Just n) = Just (n + 1)
incMaybe Nothing = Nothing

reverseMaybe :: Maybe String -> Maybe String
reverseMaybe (Just str) = Just (reverse str)
reverseMaybe Nothing = Nothing

successStr :: Maybe String
successStr = show <$> successfulRequest

failStr :: Maybe String
failStr = show <$> failedRequest

data RobotPart =
  RobotPart
    { name :: String
    , description :: String
    , cost :: Double
    , count :: Int
    }
  deriving (Show)

leftArm :: RobotPart
leftArm =
  RobotPart
    { name = "left arm"
    , description = "left arm for face punching!"
    , cost = 1000.00
    , count = 3
    }

rightArm :: RobotPart
rightArm =
  RobotPart
    { name = "right arm"
    , description = "right arm for kind hand gestures"
    , cost = 1025.00
    , count = 5
    }

robotHead :: RobotPart
robotHead =
  RobotPart
    { name = "robot head"
    , description = "this head looks mad"
    , cost = 5092.25
    , count = 2
    }

type HTML = String

renderHTML :: RobotPart -> HTML
renderHTML robotPart =
  mconcat
    [ "<h2>"
    , partName
    , "</h2>"
    , "<p><h3>desc</h3>"
    , partDesc
    , "</p><p><h3>cost</h3>"
    , partCost
    , "</p><p><h3>count</h3>"
    , partCount
    , "</p>"
    ]
  where
    partName = name robotPart
    partDesc = description robotPart
    partCost = show (cost robotPart)
    partCount = show (count robotPart)

partsDB :: Map.Map Int RobotPart
partsDB = Map.fromList keyVals
  where
    keyVals = zip [1, 2, 3] [leftArm, rightArm, robotHead]

partsDbHTML :: Map.Map Int HTML
partsDbHTML = renderHTML <$> partsDB

data Box a =
  Box a
  deriving (Show)

instance Functor Box where
  fmap func (Box n) = Box (func n)

myBox :: Box Int
myBox = Box 1

boxBoxer :: a -> Box a
boxBoxer val_from_box = Box val_from_box

boxUnboxer :: Box a -> a
boxUnboxer (Box a) = a

moreBoxes :: a -> [a]
moreBoxes a = replicate 10 a
