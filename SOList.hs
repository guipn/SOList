module SOList (
    Algorithm,
    SearchResult,
    insert,
    delete,
    search,
) where

data Algorithm = Transpose | MoveToFront
type SearchResult a = (Maybe a, [a])

insert :: (Eq a) => a -> [a] -> [a]
insert elt [] = [elt]
insert elt list @ (x:xs) | x == elt = list
                         | otherwise = x : insert elt xs

delete :: (Eq a) => a -> [a] -> [a]
delete elt [] = []
delete elt (x:xs) | x == elt  = xs
                  | otherwise = x : delete elt xs


search :: (Eq a) => Algorithm -> a -> [a] -> SearchResult a

search _ _ [] = (Nothing, [])

search _ elt [x] | x == elt  = (Just x,  [x])
                 | otherwise = (Nothing, [x])

search _ elt (x:xs) | x == elt  = (Just elt, x:xs)
search _ elt (x:y:ys) | y == elt = (Just elt, y:x:ys)


search Transpose elt (x:y:ys) = reWrap x (search Transpose elt $ y:ys)
    where reWrap notIt (result, rest) = (result, notIt : rest)

search MoveToFront elt (x:y:ys) = warp [x,y] (search MoveToFront elt ys)
    where warp notFound (result, rest) = case result of
                                            Just x  -> (result, x : notFound ++ (delete x rest))
                                            Nothing -> (Nothing, notFound ++ rest)
