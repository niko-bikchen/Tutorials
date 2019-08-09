data User =
  User
    { userID :: Int
    , name :: String
    , score :: Int
    }
  deriving (Show)

readInt :: IO Int
readInt = read <$> getLine

main :: IO ()
main = do
  putStrLn "Enter userID, name, score"
  user <- User <$> readInt <*> getLine <*> readInt
  print user
