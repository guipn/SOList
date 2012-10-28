# SOList

 This is an implementation of self-organizing lists in [Haskell] (http://haskell.org). To remain pure, it does not spend constant time for swapping. It's nonetheless simple to grok, provided you know the syntax, and should be useful in scenarios where more complex ADTs are not an option.

## Operations

 Lists are treated as sets, and there are 3 operations:

<pre>
insert :: (Eq a) => a -> [a] -> [a]
delete :: (Eq a) => a -> [a] -> [a]
search :: (Eq a) => Algorithm -> a -> [a] -> SearchResult a
</pre>

 An `insert`-ion of `x` will guarantee there is a single occurrence of `x` within the returned list.

 A `delete`-ion of `x` will guarantee that, if there was one occurrence of `x` within the parameter list, the returned list will not contain it.

 A `search` for `x`, assuming it exists, modifies its position within the list according to the heuristics defined by the `Algorithm` argument. This is an algebraic data type defined as such:

<pre>
data Algorithm = Transpose | MoveToFront
</pre>

 The result of a `search` is:

<pre>
type SearchResult a = (Maybe a, [a])
</pre>

 The second element of the returned tuple is the newly-organized list, according to the chosen `Algorithm`:

<pre>
Prelude> :l SOList.hs
[1 of 1] Compiling SOList           ( SOList.hs, interpreted )
Ok, modules loaded: SOList.
*SOList> search MoveToFront 5 [1 .. 5]
(Just 5,[5,1,2,3,4])
*SOList> let transposed = search Transpose 3 [1 .. 3] in transposed
(Just 3,[1,3,2])
*SOList> search Transpose 3 $ snd transposed
(Just 3,[3,1,2])
</pre>
