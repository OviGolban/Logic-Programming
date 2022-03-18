fib(0,0).
fib(1,1).
fib(N,Z):- N1 is N-1,fib(N1,Z1), N2 is N-2,fib(N2,Z2), Z is Z1+Z2.
