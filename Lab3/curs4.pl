sum2(L,R):-sum2(L,0,R).
sum2([], Acc, Acc).
sum2([H|T],Sum,R):- Acc1 is Acc+H, sum2(T,Acc1, R).


sum1([],0).
sum1([H|T],R):-  sum1(T,R1),R is R1+H.

pack([],X,0).
pack([X|T],X,Y):- pack(T,X,Z), Y is 1+Z.
pack([_|T],X,Z):- pack(T,X,Z).