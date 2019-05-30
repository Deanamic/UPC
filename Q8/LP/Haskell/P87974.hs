main :: IO ()
main = do
  name <- getLine
  putStrLn $ hola name

hola :: String -> String
hola (s : xs)
  | s == 'A' = "Hello!"
  | s == 'a' = "Hello!"
  | otherwise = "Bye!"
