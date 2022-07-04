member1(X, [X|_]) :- !.
member1(X, [_|T]) :- member1(X, T).

delete1(X, [X|T], T) :- !.
delete1(X, [H|T], [H|R]) :- delete1(X, T, R).
delete1(_, [], []).

length1([], 0).
length1([_|T], Len) :- length1(T, Lcoada), Len is 1+Lcoada.

length2([], Acc, Len) :- Len=Acc.
length2([_|T], Acc, Len) :- Acc1 is Acc + 1, length2(T, Acc1, Len).
length2_pretty(L, R) :- length2(L, 0, R).



%%%%%%%%%%%%%%%ex1
inters([],_,[]).
inters([H|T],L2,Rez):-member(H,L2),!,inters(T,L2,R1), Rez=[H|R1].
inters([_|T1],L2,Rez):- inters(T1,L2,Rez).


%%%%%%%%%%%%%%%%ex2
diff([],_,[]).
diff([H|T],L2,Rez):- not(member(H,L2)),!,diff(T,L2,R1), Rez=[H|R1].
diff([_|T1],L2,Rez):- diff(T1, L2, Rez).

%%%%%%%%%%%%%%%%%ex3
min1([H|T], M):- min1(T, M), M<H, !.
min1([H|_], H).

max1([H|T], M):- max1(T, M), M>H, !.
max1([H|_], H).

%%del_min([],[]).
%%del_min([H|T],R):- min1([H|T],X),X==H, del_min([H|T],R).
%%del_min([H|T],R):- min1([H|T],X),X\=H, del_min(T,R1), R=[H|R1].

del_minimum([],_,[]).
del_minimum([H|T],L,R):- min1(L,X), X==H, del_minimum(T,L,R). 
del_minimum([H|T],L,R):- min1(L,X), X\=H, del_minimum(T,L,R1), R=[H|R1].

del_min(L,R):-del_minimum(L,L,R).

del_maximum([],_,[]).
del_maximum([H|T],L,R):- max1(L,X), X==H, del_maximum(T,L,R). 
del_maximum([H|T],L,R):- max1(L,X), X\=H, del_maximum(T,L,R1), R=[H|R1].

del_max(L,R):-del_maximum(L,L,R).



%%%%%%%%%%%%%%ex6
left([H|T],R):- append(T,[H],R).

right([H|T],R):- left(R,[H|T]).

rotate_right(L,X,R):- X\=0, right(L,R1), X1 is X-1, rotate_right(R1, X1, R).
rotate_right(L,0,L).

reverse1([], []).
reverse1([H|T], R) :- reverse1(T, R1), append(R1, [H], R).


%%%%%%%%%%%%ex 4
%rev_k([],_,[]).
%rev_k(L, X, R):- 

rev_k([H|T], X, Ind,[H1|R]):- Ind < X,! ,H1 = H, Ind1 is Ind + 1, rev_k(T,X,Ind1,R).
rev_k(T,X,Ind,R):- Ind >= X, reverse1(T,R).
rev_k(L,X,R):-rev_k(L,X,0,R).



%%%%%%%%%%%%%%%%ex5

rle_encode1([H|T], T, I, R) :- H = T, !, I1 is I + 1, rle_encode1(T, H, I1, R).
rle_encode1([H|T], X, I, [H1|R]) :- H1 = [X, I], rle_encode1(T, H, 1, R).
rle_encode1([], X, I, [H1|R]) :- H1 = [X, I], R = [].
rle_encode([H|T], R) :- rle_encode1(T, H, 1, R).

%%rev_k(L,X,R)



