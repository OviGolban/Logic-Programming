separate_parity([], E, O):- E=[], O=[].
separate_parity([H|T], E, O):- X is H mod 2, X ==0,separate_parity(T,E1,O),E=[H|E1].
separate_parity([H|T], E, O):- X is H mod 2, X \=0,separate_parity(T,E,O1), O=[H|O1].