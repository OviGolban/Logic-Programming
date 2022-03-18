member1(X, [X|_]).
member1(X, [_|T]) :- member1(X, T).



remove([X|R1],L):- member1(X,R1), remove(R1,L).
remove([X|R1],[X|R2]):- not(member1(X,R1)),remove(R1,R2).
remove([],[]).