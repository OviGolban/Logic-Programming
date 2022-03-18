fib2(1,_,R,R).
fib2(X,Acc1,Acc2,R):-X>1, X1 is X-1, Acc3 is Acc1+Acc2, fib2(X1,Acc2,Acc3,R).
fib2(X,R):- fib2(X,0,1,R).