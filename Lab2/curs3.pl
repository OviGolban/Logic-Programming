length1([], 0).
length1([_|T],L):- length1(T, L1), L is L1+1.

list_length([_|T], Len, R):-  Len1 is Len+1, 
						list_length(T, Len1, R).
list_length([], Len, Len).

reverse([],[]).
reverse([H|T], L):- reverse(T,L1), append(L1, [H], L).