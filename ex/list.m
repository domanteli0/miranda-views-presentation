peano ::= Zero | Succ peano
lint a ::= Nil | (list a) Snoc a
    inout (x Cons Nil) = Nil Snoc z
    inout (x Cons (xs Snot x')) = (x Cons xs) Snot x'

view int ::= Zero | Succ peano
    out Zero = 0
    out (Succ n) = n + 1