data Stack : Type -> Type where
    Empty : Stack el
    IsEmpty : Stack el -> bool
    Push : el -> Stack el -> Stack el
    Pop : Stack el -> Stack el
        Top : Stack el -> el

stack * == [*]
empty = []
isempty x = (x=[])
push a x = (a:x)
pop (a:x) = x
top (a:x) = a