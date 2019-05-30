data Queue a = Queue [a] [a]
  deriving (Show)

create :: Queue a
create = Queue [] []

fix :: Queue a -> Queue a
fix (Queue l r) = Queue (l ++ reverse r) []

push :: a -> Queue a -> Queue a
push x (Queue l r)  = Queue l (x : r)

pop :: Queue a -> Queue a
pop (Queue l r)
  | null l && null r = (Queue [] [])
  | null l = pop (fix (Queue l r))
  | otherwise = (Queue (drop 1 l) r)

top :: Queue a -> a
top (Queue l r)
  | null l = top (fix (Queue l r))
  | otherwise = head l

empty :: Queue a -> Bool
empty (Queue l r) = null l && null r

instance (Eq a) => Eq (Queue a) where
  (Queue l r) == (Queue l1 r1) = (l ++ reverse (r)) == (l1 ++ reverse r1)

instance Functor Queue where
  fmap g (Queue l r) = (Queue (fmap g l) (fmap g r))

translation :: Num b => b -> Queue b -> Queue b
translation x q = (fmap (+x)) q

union :: Queue a -> Queue a -> Queue a
union (Queue l r) (Queue l1 r1) = (Queue (l ++ reverse r) (r1 ++ reverse l1))

instance Applicative Queue where
  pure x = Queue [x] []
  -- (Queue fl fr) <*> (Queue l r) = Queue [f x | f <- fl ++ reverse fr, x <- l ++ reverse r] []
  (Queue fl fr) <*> (Queue l r) = Queue (fl ++ reverse fr <*> l ++ reverse r) []

instance Monad Queue where
  (Queue l r) >>= f = foldl (union) (Queue [] []) (map f l1)
    where l1 = l ++ reverse r

kfilter :: (p -> Bool) -> Queue p -> Queue p
kfilter b q = do {x <- q ; if (b x) then return x else (Queue [] []) }
