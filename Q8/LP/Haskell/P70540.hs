data Expr = Val Int | Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr

eval1 :: Expr -> Int

eval1 (Val v) = v

eval1 (Add e1 e2) = eval1 e1 + eval1 e2

eval1 (Sub e1 e2) = eval1 e1 - eval1 e2

eval1 (Mul e1 e2) = eval1 e1 * eval1 e2

eval1 (Div e1 e2) = (eval1 e1) `quot` (eval1 e2)

eval2 :: Expr -> Maybe Int

eval2 (Val v) = return v

eval2 (Add e1 e2) = calc (+) (e1) (e2)

eval2 (Sub e1 e2) = calc (-) (e1) (e2)

eval2 (Mul e1 e2) = calc (*) (e1) (e2)

eval2 (Div e1 e2) = do {
  x1 <- (eval2 e1) ;
  x2 <- (eval2 e2) ;
  if x2 == 0 then Nothing else Just (quot x1 x2) }

calc :: (Int -> Int -> Int) -> Expr -> Expr -> Maybe Int
calc f x y = do {i <- eval2 x; j <- eval2 y; Just (f i j)}

eval3 :: Expr -> Either String Int

eval3 (Val v) = return v

eval3 (Add e1 e2) = calc2 (+) (e1) (e2)

eval3 (Sub e1 e2) = calc2 (-) (e1) (e2)

eval3 (Mul e1 e2) = calc2 (*) (e1) (e2)

eval3 (Div e1 e2) = do {
  x1 <- (eval3 e1) ;
  x2 <- (eval3 e2) ;
  if x2 == 0 then Left "div0" else Right (quot x1 x2) }


calc2 :: (Int -> Int -> Int) -> Expr -> Expr -> Either String Int
calc2 f x y = do {i <- eval3 x; j <- eval3 y; Right (f i j)}
-- instance Monad Maybe where
--   return x = Just x
--   Nothing >>= _ = Nothing
--   (Just x) >>= f = f x
