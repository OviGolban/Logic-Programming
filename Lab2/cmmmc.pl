cmmdc2(X, 0, X). %param 3 e rez lui cmmdc
cmmdc2(X,Y,Z):- Rest is X mod Y, cmmdc2(Y, Rest, Z).

cmmmc(X,Y,R):- cmmdc2(X,Y,Z), R is (X*Y)/Z. 