import System.IO

main :: IO ()
main = do
        -- helloFile <- openFile "hello.txt" ReadMode
        -- firstLine <- hGetLine helloFile
        -- putStrLn firstLine
        -- secondLine <- hGetLine helloFile
        -- putStrLn secondLine
        -- goodbyeFile <- openFile "goodbye.txt" WriteMode
        -- hPutStrLn goodbyeFile secondLine
        -- hClose helloFile
        -- hClose goodbyeFile
        -- putStrLn "Done!"
        helloFile <- openFile "hello.txt" ReadMode
        hasLine <- hIsEOF helloFile
        firstLine <- if not hasLine then hGetLine helloFile else return "Empty"
        putStrLn "Done !"