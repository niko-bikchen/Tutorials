import System.Random

minDie :: Int
minDie = 1

func :: Int
func = let 
        a = 10
        c = 20
        in
        a * c

helloPerson :: String -> String
helloPerson name = "Hello " ++ name ++ " !"

maxDie :: Int
maxDie = 6

main :: IO ()
main = do
    putStrLn "What's your name ?"
    name <- getLine
    let greeting = helloPerson name
    putStrLn greeting