append2([], L2, R) :- R=L2.
append2([H|T], L2, R) :- append2(T, L2, CoadaR), R=[H|CoadaR].

append3([], [], [], []).
append3(L1,L2,L3,R):- append2(L2,L3,R1),append2(L1,R1,R).