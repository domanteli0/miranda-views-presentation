





fac : Nat -> Nat

fac n @ Z = 1
fac n @ (S n')
    = n * fac n'
