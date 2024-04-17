firstLast Nil = Nothing
firstLast x Cons Nil = Nothing
firstLast x Cons (xs Snoc x') = Just (x, x')
