stack * == [*]
empty = []
isempty x = (x=[])
push a x = (a:x)
pop (a:x) = x
top (a:x) = a