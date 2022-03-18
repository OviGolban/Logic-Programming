add_last(X,[],[X]).
add_last(X,[H|T],R):- add_last(X,T,R1), R=[H|R1].

add_first(X,[],X).
add_first(X,L,[X|L]).