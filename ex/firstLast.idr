firstLast : List a -> Maybe (a, a)
firstLast [] = Nothing
firstLast (x :: xs) with (mySnocList xs)
  firstLast (x :: []) | MyEmpty = Nothing
  firstLast (x :: (ys ++ [y])) | (MySnoc y ys rec) = Just (x, y)
