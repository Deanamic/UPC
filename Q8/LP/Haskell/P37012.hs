data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)

size :: Tree a -> Int
size Empty = 0
size (Node x l r) = 1 + size l + size r

height :: Tree a -> Int
height Empty = 0
height (Node x l r) = 1 + max (height l) (height r)

equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal _ Empty = False
equal Empty _ = False
equal (Node x l r) (Node x1 l1 r1) = x == x1 && equal l1 l && equal r1 r

isomorphic :: Eq a => Tree a -> Tree a -> Bool
isomorphic Empty Empty = True
isomorphic Empty _ = False
isomorphic _ Empty = False
isomorphic (Node x l r) (Node x1 l1 r1) = x == x1 && ((isomorphic l1 l && isomorphic r1 r) ||
  (isomorphic l1 r && isomorphic r1 l))

preOrder :: Tree a -> [a]
preOrder Empty = []
preOrder (Node x l r) = x : preOrder l ++ preOrder r

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node x l r) = postOrder l ++ postOrder r ++ [x]

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node x l r) = inOrder l ++ [x] ++ inOrder r

bfs [] = []
bfs (Empty : x) = bfs x
bfs ((Node n l r) : x) = n : bfs (x ++ [l,r])

breadthFirst :: Tree a -> [a]
breadthFirst t = bfs [t]

build :: Eq a => [a] -> [a] -> Tree a
build [] [] = Empty
build p@(px : pxs) i = Node px (build lp li) (build rp ri)
  where (li,_:ri) = span (/=px) i
        (lp,rp) = splitAt (length li) pxs



-- overlap
overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
overlap _ Empty Empty = Empty
overlap _ a Empty = a
overlap _ Empty b = b
overlap f (Node ax al ar) (Node bx bl br) = Node (f ax bx) (overlap f al bl) (overlap f ar br)
