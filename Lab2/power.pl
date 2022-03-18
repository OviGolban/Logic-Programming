power1(X,1,X).
power1(X,Y,Z):- Y1 is Y-1, power1(X, Y1, Z1), Z is X*Z1.