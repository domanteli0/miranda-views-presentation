pow : Nat -> Nat -> Nat
pow x Z = 1
pow x (S k) = x * pow x k