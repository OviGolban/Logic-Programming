power2(X,0,Acc,F):- F=Acc.
power2(X,Y,Acc,F):- Y>0, Y1 is Y-1, Acc1 is Acc*X, power2(X,Y1,Acc1,F).
power2(X,Y,F):- power2(X,Y,1,F).