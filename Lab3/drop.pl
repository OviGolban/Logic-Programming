drop([],_,_,[]).
drop([H|T], P, N, [H|Rez]):- 0=\=P mod N, P1 is P+1, drop(T,P1,N,Rez).
drop([_|T], P, N, Rez):- 0 =:= P mod N, P1 is P+1, drop(T,P1,N, Rez).

drop_k(L,X,Rez):- integer(X), X > 0, drop(L,1,X,Rez).