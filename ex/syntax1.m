nat ::= S nat | Z

fib :: nat -> num
fib Z = 0
fib (S Z) = 1
fib (S (S k)) = fib k + fib (S k)
