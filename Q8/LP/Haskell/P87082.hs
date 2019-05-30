import System.Environment
-- import Control.Monad

main :: IO ()
main = do
  line <- getLine
  if (line /= "*") then do
    solve line
    main
  else return ()

message w h
  | imc<18 = "underweight"
  | imc>=18 && imc<25 = "normal weight"
  | imc>=25 && imc<30 = "overweight"
  | imc>=30 && imc<40 = "obese"
  | otherwise = "severely obese"
  where imc = w/(h^2)

solve l = putStrLn $ name ++ ": " ++ message w h
  where
    (name:xs) = words l
    [w,h] = map read $ xs :: [Float]
