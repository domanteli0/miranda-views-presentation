fib :: int -> int
fib Zero             = Zero
fib (Succ Zero)      = Succ Zero
fib (Succ (Succ n))  = (fib n) + (fib (Succ n))