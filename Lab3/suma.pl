suma([],S):- S is 0.
suma([H|T],S):- suma(T,S1), S is S1+H.