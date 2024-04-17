data As : a -> Type where
  (@@) : a -> a -> As a

as : a -> As a
as a = a @@ a

fac : Nat -> Nat
fac n with (as n)
  fac _ | (n @@ Z) = 1
  fac _ | (n @@ (S n'))
    = n * fac n'