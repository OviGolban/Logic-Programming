replace(_,_,[],[]).
replace(X,A,[H|T], R):- X \=H, replace(X,A,T,R1),R=[H|R1].
replace(X,A,[H|T], R):- X ==H, replace(X,A,T,R1), R=[A|R1].