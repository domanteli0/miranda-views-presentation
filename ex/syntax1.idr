data Nat = S Nat | Z

fib : Nat -> Int
fib Z = 0
fib (S Z) = 1
fib (S (S k)) = fib k + fib (S k)