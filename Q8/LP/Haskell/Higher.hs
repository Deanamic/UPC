eql :: [Int] -> [Int] -> Bool
eql a b = length a == length b && all (==True) (zipWith (==) a b)

prod :: [Int] -> Int
prod a = foldl (*) 1 a

prodOfEvens :: [Int] -> Int
prodOfEvens a = prod [x | x <- a, mod x 2 == 0]

powersOf2 :: [Int]
powersOf2 = iterate (*2) 1

scalarProduct :: [Float] -> [Float] -> Float
scalarProduct a b = foldl (+) 0 (zipWith (*) a b)

flatten :: [[Int]] -> [Int]
flatten [] = []
flatten l = foldl (++) [] l

myLength :: String -> Int
myLength s = foldl (\x _ -> x+1) 0 s

myReverse :: [Int] -> [Int]
myReverse a = foldl (\xs x -> x:xs) [] a

countIn :: [[Int]] -> Int -> [Int]
countIn l x = foldr (\ax axs -> (foldl (\y z -> if(z == x) then (y+1) else y) 0 ax) : axs) [] l

firstWord :: String -> String
firstWord s = takeWhile (/=' ') $ dropWhile (==' ') s

myMap :: (a -> b) -> [a] -> [b]
myMap f b = [ f x | x <- b]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f l = [ x | x <- l, f x]

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f a b = [f x y | (x, y) <- zip a b]

thingify :: [Int] -> [Int] -> [(Int,Int)]
thingify a b = [ (x, y) | x <- a , y <- b, mod x y == 0]

factors :: Int -> [Int]
factors a = [x | x <- [1..a], mod a x == 0]



myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl _ x [] = x
myFoldl f a (x : xs) = myFoldl f (f a x) xs

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ x [] = x
myFoldr f a (x : xs) = f x (myFoldr f a xs)

myIterate :: (a -> a) -> a -> [a]
myIterate f x = x : myIterate f (f x)

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil b f a
  | b a = a
  | otherwise = myUntil b f (f a)

-- myMap :: (a -> b) -> [a] -> [b]
-- myMap f a = myFoldr (\x xs -> (f x):xs) [] l

-- myFilter :: (a -> Bool) -> [a] -> [a]
-- myFilter = myFoldr (\x xs -> if f x then x:xs else xs) [] l

myAll :: (a -> Bool) -> [a] -> Bool
myAll f l = and (myMap f l)

myAny :: (a -> Bool) -> [a] -> Bool
myAny f l = or (myMap f l)

myZip :: [a] -> [b] -> [(a, b)]
myZip [] _ = []
myZip _ [] = []
myZip (a1:a) (b1:b) = (a1,b1) : myZip a b

-- myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
-- myZipWith f a b = myFoldr (\x xs -> (f (fst x) (snd x)):xs) [] (myZip a b)

countIf :: (Int -> Bool) -> [Int] -> Int
countIf f a = length [p | p <- a, f p]

pam :: [Int] -> [Int -> Int] -> [[Int]]
pam a f = map (`map` a) f
-- pam a f = map (flip map a) f
--using backtit to flip function parameters

pam2 :: [Int] -> [Int -> Int] -> [[Int]]
pam2 a f = map (\x -> map ($ x) f) a
-- pam2 l f = map (\x -> map ($ x) f) l

filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int
filterFoldl b f a x = foldl f a [p | p <- x, b p]

insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert f a v = [x | x <- a, f x v] ++ v : [x | x <- a, not(f x v)]

insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int]
insertionSort f x = myFoldl (insert f) [] x
-- insertionSort f (x : xs) = insert f (insertionSort f xs) x

ones :: [Integer]
ones = 1 : ones

nats :: [Integer]
nats = iterate (+1) 0

ints :: [Integer]
ints = 0 : concatMap (\x -> [x, -x]) (iterate (+1) 1)

triangulars :: [Integer]
triangulars = 0 : zipWith (+) triangulars (iterate (+1) 1)

factorials :: [Integer]
factorials = 1 : zipWith (*) factorials (iterate (+1) 1)

primes :: [Integer]
primes = sieve (iterate (+1) 2)
  where sieve (p:xs) =
          p : sieve [x | x <- xs, x `mod` p /= 0]

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (drop 1 fibs)

hammings :: [Integer]
hammings = 1 : merge (merge (map (*2) hammings) (map (*3) hammings)) (map (*5) hammings)
  where merge (x:xs) (y:ys)
          | x < y = x : xs `merge` (y:ys)
          | x > y = y : (x:xs) `merge` ys
          | otherwise = x : xs `merge` ys

myGroup :: [Char] -> [[Char]]
myGroup [] = []
myGroup x = getHead : (myGroup cua)
  where
    hd = head x
    getHead = takeWhile (== hd) x
    cua = dropWhile (== hd) x

lookNsay :: [Integer]
lookNsay = 1 : map (read.concatMap (\x -> (show $ length x) ++ (take 1 x)).myGroup.show) lookNsay

tartaglia :: [[Integer]]
tartaglia = [1] : map (\x -> zipWith (+) (x ++ [0]) (0 : x)) tartaglia
