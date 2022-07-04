max(E1,E2,R):- E1 > E2, R is E1.
max(_,E2,R):- R is E2.

depth([],1).
depth([H|T],R):- atomic(H), !, depth(T,R).
depth([H|T],R):- depth(H,R1), depth(T,R2), R3 is R1+1, max(R3,R2,R).

flatten([],[]).
flatten([H|T], [H|R]):- atomic(H), !, flatten(T,R).
flatten([H|T], R):- flatten(H,R1), flatten(T,R2), append(R1,R2,R).

heads([],[],_).
% dacă flag=1 atunci suntem la început de lista și putem extrage capul listei; în apelul recursiv setam flag=0
heads([H|T],[H|R],1):- atomic(H), !, heads(T,R,0).
% dacă flag=0 atunci nu suntem la primul element atomic și atunci continuam cu restul elementelor
heads([H|T],R,0):- atomic(H), !, heads(T,R,0).
% dacă am ajuns la aceasta clauza înseamnă că primul element nu este atomic și atunci trebuie să apelam recursiv și pe acest element
heads([H|T],R,_):- heads(H,R1,1), heads(T,R2,0), append(R1,R2,R).
heads_pretty(L,R):- heads(L, R, 1).



%%%%%%%ex1
count_atomic([],0).
count_atomic([H|T],R):- atomic(H),!,count_atomic(T,R1), R is R1+1.
count_atomic([_|T],R):- count_atomic(T,R).


%%%%%%%%ex2
sum_atomic([],0).
sum_atomic([H|T],R):- atomic(H),!,sum_atomic(T,R1), R is R1+H.
sum_atomic([_|T],R):- sum_atomic(T,R).

%%%%%%%%ex3
member1(H,[H|_]):-!.
member1(X,[H|_]):-member1(X,H).
member1(X,[_|T]):-member1(X,T).

%%%%%%%%???ex4

length1([], 0).
length1([_|T],L):- length1(T, L1), L is L1+1.

laste([], []).
laste([_|T], R):- length1(T,R1), R1 is 1,!, R=T.
laste([_|T], R):- length1(T,R1), R1 \= 1,!, laste(T, R).


lasts([],[]).
lasts([H|[]], [H]):- atomic(H), T=[].
lasts([H|T], R):- atomic(H),lasts(T, R).
lasts([H|T],R):- lasts(H,R1), lasts(T, R2),R=[R1|R2].



%%%%%%%%ex5
replace(_,_,[],[]).
replace(X,Y,[H|T],R):- atomic(H), X == H,!, replace(X,Y,T,R1), R=[Y|R1].
replace(X,Y,[H|T],R):- atomic(H), X \= H,!, replace(X,Y,T,R1), R=[H|R1].
replace(X,Y,[H|T],R):- replace(X,Y,H,R1), replace(X,Y,T,R2), R=[R1|R2].