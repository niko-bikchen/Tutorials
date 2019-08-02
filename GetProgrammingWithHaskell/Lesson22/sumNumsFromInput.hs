import Control.Monad
import System.Environment

main :: IO ()
main = do
  args <- getArgs
  let linesToRead =
        if length args > 0
          then read (head args)
          else 0 :: Int
  numbers <- replicateM linesToRead getLine
  let ints = map read numbers :: [Int]
  print (sum ints)

mainExample :: IO ()
mainExample = do
  vals <- mapM (\_ -> getLine) [1 .. 3]
  mapM_ putStrLn vals

myReplicateM :: Monad m => Int -> m a -> m [a]
myReplicateM n func = mapM (\_ -> func) [1 .. n]
