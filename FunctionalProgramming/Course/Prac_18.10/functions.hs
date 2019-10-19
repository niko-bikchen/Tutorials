{-# OPTIONS_GHC -Wall #-}

putN2 :: Int -> String -> IO ()
putN2 n str = do
  putStrLn str
  guard (n > 1)
  putStrLn str

putN :: Int -> String -> IO ()
putN n str =
  if n <= 1
    then putStrLn str
    else do
      putStrLn str
      putN (n - 1) str

sum2 :: IO ()
sum2 = do
  a <- getLine
  b <- getLine
  putStrLn $ evalSum a b

evalSum :: String -> String -> String
evalSum a b =
  case (takeInt a, takeInt b) of
    (Just x, Just y) -> show $ x + y
    (_, _) -> "Error. Input doesn't contain any numbers/"

takeInt :: String -> Maybe Int
takeInt s
  | all (`elem` "0123456789") s = Just (read s)
  | otherwise = Nothing
