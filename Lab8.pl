tree1(t(7, t(5, t(3,_,_), t(6,_,_)), t(11,_,_))).
tree2(t(7, t(5, t(3,_,_), _), t(11,_,_))).

tree3(t(6, t(4,t(2,nil,nil),t(5,nil,nil)), t(9,t(7,nil,nil),nil))).

% trebuie testat explicit faptul ca am ajuns la sfârșitul listei
% și nu am găsit elementul căutat
member_il(_, L):-var(L), !, fail.
% celelalte 2 clauze sunt la fel ca în trecut
member_il(X, [X|_]):-!.
member_il(X, [_|T]):-member_il(X, T).

% am ajuns la finalul listei atunci putem adăuga elementul
insert_il(X, L):-var(L), !, L=[X|_].
insert_il(X, [X|_]):-!. % elementul există deja
insert_il(X, [_|T]):- insert_il(X, T).

delete_il(_, L, L):-var(L), !. % am ajuns la finalul listei
delete_il(X, [X|T], T):-!. % ștergem prima apariție și ne oprim
delete_il(X, [H|T], [H|R]):-delete_il(X, T, R).

search_it(_, T):-var(T),!,fail.
search_it(Key, t(Key, _, _)):-!.
search_it(Key, t(K, L, _)):-Key<K, !, search_it(Key, L).
search_it(Key, t(_, _, R)):-search_it(Key, R).


% inserează sau verifică dacă elementul există deja în arbore
insert_it(Key, t(Key, _, _)):-!.
insert_it(Key, t(K, L, R)):-Key < K, !, insert_it(Key, L).
insert_it(Key, t(_, _, R)):-insert_it(Key, R).

delete_it(Key, T, T):-var(T),!.
delete_it(Key, t(Key, L, R), L):-var(R),!.
delete_it(Key, t(Key, L, R), R):-var(L),!.
delete_it(Key, t(Key, L, R), t(Pred,NL,R)):-!,get_pred(L,Pred,NL).
delete_it(Key, t(K,L,R), t(K,NL,R)):-Key<K,!,delete_it(Key,L,NL).
delete_it(Key, t(K,L,R), t(K,L,NR)):-delete_it(Key,R,NR).
% caută nodul predecesor
get_pred(t(Pred, L, R), Pred, L):-var(R),!.
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-get_pred(R, Pred, NR).

%%%%%%%%%%%ex1
append2([], L2, L2):- !.
append2([H|_], L2, L):- var(H), !, append2(L2, H, L).
append2([H|T], L2, [H|CoadaR]) :- append2(T, L2, CoadaR).


%%%%%%%%%%ex2
reverse1([], []).
reverse1([H|T], R) :- reverse1(T, R1), append(R1, [H], R).

reverse_il(L, L):- var(L), !.
reverse_il([H|T], R) :- reverse_il(T, R1), append2(R1, [H|_], R).


%%%%%%%%%ex3
list_il([H|_],[]):- var(H), !.
list_il([H|T], [H|R]):- list_il(T,R).

list_cl([],_).
list_cl([H|T], [H|R]):- list_cl(T,R).


%%%%%%%ex4
preorder(T, _):- var(T), !.			
preorder([], []).
preorder(t(K,L,R), List):-preorder(L,LL), preorder(R, LR),append([K|LL], LR, List).

%%%%%%%ex5
max(E1,E2,R):- E1 > E2,! , R is E1.
max(_,E2,R):- R is E2.

height([T], 0):- var(T), !.
height(t(_, L, R), H):-height(L, H1), 
					height(R, H2),
					max(H1, H2, H3), 
					H is H3+1.
					
%%%%%%%%%%ex6
tree_il(T, []):- var(T), !.
tree_il(t(K,L,R), t(K, NL, NR)):- tree_il(L, NL), tree_il(R, NR).

tree_cl(nil, _).
tree_cl(t(K,L,R), t(K, NL, NR)):- tree_cl(L, NL), tree_cl(R, NR).



%%%%%%%ex7
flat_il(T, _):- var(T), !.
flat_il([H|T], [H|R]):- atomic(H), !, flat_il(T,R).
flat_il([H|T], R):- flat_il(H,R1), flat_il(T,R2), !, append2(R1,R2,R).


					
%%%%%%%ex8

diam([T], 1):- var(T), !.
diam(nil, 0).
diam(t(_, L, R), D):- diam(L, D1), diam(R, D2), height(L, H1), height(R, H2), H3 is H2+H1+1 , max(D1,D2,D3), max(D3,H3,D).