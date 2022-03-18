solve(0,B,C,X):- X is (-C)/B.
solve(A,B,C,X):- X is (-B-sqrt(B*B-4*A*C))/2*A; X is (-B+sqrt(B*B-4*A*C))/2*A .