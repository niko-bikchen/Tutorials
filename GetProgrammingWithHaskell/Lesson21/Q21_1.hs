import qualified Data.Map as Map

person :: Map.Map Int String
person = Map.fromList [(1, "Username")]

helloPerson :: String -> String
helloPerson name = "Hello" ++ " " ++ name ++ "!"

helloMain :: Maybe String
helloMain = do
  name <- Map.lookup 1 person
  let statement = helloPerson name
  return statement
