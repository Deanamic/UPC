sumMultiples35 :: Integer -> Integer
sumMultiples35 n = (3*(quot (n3*(n3+1)) 2)) + (5 * (quot (n5*(n5+1)) 2)) - (15 * quot (n15*(n15+1)) 2)
  where
    n3 = quot (n-1) 3
    n5 = quot (n-1) 5
    n15 = quot (n-1) 15



fibonacci :: Int -> Integer
fibonacci n =  fib !! n
  where fib = 0 : 1 : zipWith (+) fib (drop 1 fib)

sumEvenFibonaccis :: Integer -> Integer
sumEvenFibonaccis n = foldl (+) 0 [x | x <- fib, mod x 2 == 0, x < n]
  where fib = takeWhile (< n) (0 : 1 : zipWith (+) fib (drop 1 fib))

isPalindromic :: Integer -> Bool
isPalindromic s = (show s) == reverse (show s)

primes :: [Int]
primes = sieve (iterate (+1) 2)
  where sieve (p:xs) =
          p : sieve [x | x <- xs, x `mod` p /= 0]

primeFactors n = factor n primes
  where factor n (p:ps)
          | p*p>n = [n]
          | mod n p == 0 = p : factor (div n p) (p:ps)
          | otherwise      = factor n ps

largestPrimeFactor :: Int -> Int
largestPrimeFactor n = last $ primeFactors n
