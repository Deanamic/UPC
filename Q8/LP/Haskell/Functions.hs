absValue :: Int -> Int
absValue n
    | n > 0 = n
    | otherwise = - n

power :: Int -> Int -> Int
power a b
    | b == 0 = 1
    | otherwise = a * power a (b-1)

isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime a = null [p | p <- [2 .. floor ( sqrt ( fromIntegral a))], mod a p == 0]

slowFib :: Int -> Int
slowFib n
    | n == 0 = 0
    | n == 1 = 1
    | otherwise = slowFib (n-2) + slowFib (n-1)

fib :: Int -> (Int, Int)
fib 0 = (0, 1)
fib x = (r, r + q)
    where (q, r) = fib(x - 1)

quickFib :: Int -> Int
quickFib x = fst(fib x)

myLength :: [Int] -> Int
myLength [] = 0
myLength (xs : l) = 1 + myLength(l)

myMaximum :: [Int] -> Int
myMaximum (xs : x)
    | x == [] || xs > y = xs
    | otherwise = y
    where y = myMaximum x

average :: [Int] -> Float
average a = fromIntegral(foldl (+) 0 a) / fromIntegral(myLength a)


buildPalindrome :: [Int] -> [Int]
buildPalindrome a = reverse a ++ a

-- remove :: [Int] -> [Int] -> [Int]
-- remove [] _ = []
-- remove (x : xs) b
  -- | elem x b = remove xs b
  -- | otherwise = x : remove xs b

flatten :: [[Int]] -> [Int]
flatten [] = []
flatten (x : xs) = foldl (++) x xs

oddsNevens :: [Int] -> ([Int], [Int])
oddsNevens [] = ([], [])
oddsNevens (x : xs)
  | mod x 2 == 0 = (p, x : q)
  | otherwise = (x : p, q)
  where
    (p, q) = oddsNevens(xs)

primeDivisors :: Int -> [Int]
primeDivisors a = [x | x <- [2..a], mod a x == 0, isPrime x]

insert :: [Int] -> Int -> [Int]
insert a x = [b | b <- a, b <= x] ++ x : [b | b <- a, b > x]

isort :: [Int] -> [Int]
isort [] = []
isort (x : xs) = insert (isort xs) x

remove :: [Int] -> Int -> [Int]
remove (x : xs) a
  | a == x = xs
  | otherwise = x : remove xs a

ssort :: [Int] -> [Int]
ssort xs
  | xs == [] = []
  | otherwise = y : ssort(remove xs y)
  where
    y = minimum xs

merge :: [Int] -> [Int] -> [Int]
merge [] a = a
merge a [] = a
merge (a1 : a) (b1 : b)
  | a1 < b1 = a1 : merge a (b1 : b)
  | otherwise = b1 : merge (a1 : a) b

msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort x = merge (msort a) (msort b)
  where
    a = take n x
    b = drop n x
    n = div (myLength x) 2

qsort :: [Int] -> [Int]
qsort [] = []
qsort (p : x) = qsort [e | e <- x, e <= p] ++ p : qsort [e | e<-x, e > p]

genQsort :: Ord a => [a] -> [a]
genQsort [] = []
genQsort (p : x) = genQsort [e | e <- x, e <= p] ++ p : genQsort [e | e<-x, e > p]
