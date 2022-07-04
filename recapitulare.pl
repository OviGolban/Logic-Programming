%%%%%%%%ex1
cmmdc(A, A, A).
cmmdc(A, B, Res):- A>B,AN is A-B, cmmdc(AN, B, Res).
cmmdc(A, B, Res):- BN is B-A, cmmdc(A, BN, Res).

%%%%%%%ex2
cmmmc(A, A, A).
cmmmc(A, B, Res):- ResInter is A*B, cmmdc(A, B, ResInter2), Res is ResInter / ResInter2.

%%%%%ex3
divisor(N,R):-divisor_call(N,1,R).
divisor_call(N,N,[N]):-!.
divisor_call(N, X, [X|R]):- X<N, T is N mod X, T==0, X1 is X+1, !, divisor_call(N,X1,R).
divisor_call(N, X, R):- X<N, X1 is X+1, divisor_call(N,X1,R).

%%%%ex4
to_binary(0,[]):-!.
to_binary(X,R):-T is div(X, 2), T1 is X mod 2, to_binary(T, RInter), append(RInter,[T1],R).

reverse_list([],[]):-!.
reverse_list([H|T],R):-reverse_list(T,RInter), append(RInter,[H],R).



%%%%%%%%%%ex6
suma([], 0).
suma([H|T], R):- suma(T, RInter), R is RInter+H.

%%%%%%%ex7
numbers([],[]).
numbers([H|T], R):- X is H mod 2, X == 0, RInter1 is H*H, numbers(T, RInter2), R=[RInter1|RInter2].
numbers([H|T], R):- X is H mod 2, X \= 0, RInter1 is 2*H, numbers(T, RInter2), R=[RInter1|RInter2].

%%%%%%%ex8
separate_parity([], [], []).
separate_parity([H|T], [H|E], O):- X is H mod 2, X == 0, separate_parity(T, E, O).
separate_parity([H|T], E, [H|O]):- X is H mod 2, X \= 0, separate_parity(T, E, O).

%%%%%%ex9
replace_all(_, _, [], []).
replace_all(X, Y, [X|T], [Y|R]):- replace_all(X, Y, T, R).
replace_all(X, Y, [H|T], [H|R]):- replace_all(X, Y, T, R).

%%%%%%%ex11
delete_pos_even([], _, []).

delete_pos_even_aux([], _, _, []).
%delete_pos_even_aux([H|T], Ind, X, [H|R]):- X is Ind mod 2, X \= 0, Ind1 is Ind+1, delete_pos_even_aux(T, Ind1, X, R).
delete_pos_even_aux([H|T], Ind, X, R):- X is Ind mod 2, X == 0,H==X, Ind1 is Ind+1, delete_pos_even_aux(T, Ind1, X, RInter), R=RInter.
%delete_pos_even_aux([H|T], Ind, X, [H|R]):- X is Ind mod 2, X == 0,H\=X,Ind1 is Ind+1, delete_pos_even_aux(T, Ind1, X, R).
%delete_pos_even_aux([H|T], Ind, X, [H|R]):- X is Ind mod 2, X \= 0, Ind1 is Ind+1, delete_pos_even_aux(T, Ind1, X, R). 


%%%%%%%%ex14
min1([H|T],M):- min1(T,M), M<H, !.
min1([H|_],H).

sterge_min(L, R):- sterge_aux(L, L, R).
sterge_aux([],_, []):- !.
sterge_aux([H|T], L, [H|R]):- min1(L,Res), H\=Res, sterge_aux(T,L,R).
sterge_aux([H|T], L, R):- min1(L,Res),H==Res, sterge_aux(T,L,R).


max1([H|T],M):- max1(T,M), M>H, !.
max1([H|_],H).

sterge_max(L, R):- sterge_aux_max(L, L, R).
sterge_aux_max([],_, []):- !.
sterge_aux_max([H|T], L, [H|R]):- max1(L,Res), H\=Res, sterge_aux_max(T,L,R).
sterge_aux_max([H|T], L, R):- max1(L,Res),H==Res, sterge_aux_max(T,L,R).


%%%%%%%%%ex15
member1(X, [X|_]).
member1(X, [_|T]) :- member1(X, T).

sterge_duplicate([],[]).
sterge_duplicate([H|T], R):- member1(H,T), sterge_duplicate(T,R).
sterge_duplicate([H|R1], [H|R]):- sterge_duplicate(R1,R).


%%%%%%%ex16
reverse_list_incomp(L, L):- var(L), !.
reverse_list_incomp([H|T],R):-reverse_list_incomp(T,RInter), append(RInter,[H|_],R).

reverse_k(L,Pos,R):-reverse_k_aux(L,1,Pos,R).
%%reverse_k([], _,_, []):-!.
reverse_k_aux([H|T], Ind, Pos,[H|R]):-Ind =< Pos, Ind1 is Ind+1, !,reverse_k_aux(T, Ind1, Pos,R).
reverse_k_aux(L, _, _, R):- reverse_list(L, R).

%%%%%ex21
merge_sort(L, R):-
split(L, L1, L2), % împarte L în doua subliste de lungimi egale
merge_sort(L1, R1),
merge_sort(L2, R2), 
merge(R1, R2, R). % interclasează sublistele ordonate
merge_sort([H], [H]). % split returnează fail dacă lista ii vidă sau are doar un singur element
merge_sort([], []).

split(L, L1, L2):-length(L, Len), Len>1, K is Len/2, 
splitK(L, K, L1, L2).
splitK([H|T], K, [H|L1], L2):-K>0,!,K1 is K-1,splitK(T, K1, L1, L2).
splitK(T, _, [], T).
merge([H1|T1], [H2|T2], [H1|R]):-H1<H2, !, merge(T1, [H2|T2], R).
merge([H1|T1], [H2|T2], [H2|R]):-merge([H1|T1], T2, R).
merge([], L, L).
merge(L, [], L).


ascii([H|T],R):- char_code(H,R1), ascii(T,Rint), R=[R1|Rint].
ascii([],[]).

characters(R,[H|T]):- char_code(Rint,H), characters(R1, T), R=[Rint|R1].
characters([],[]).

sort_chars(L,R):- ascii(L,Rint), merge_sort(Rint, Rnou), characters(R,Rnou).
sort_chars([],[]).

max3(A,B,R):- A<B,!, R=B.
max3(A,_,R):- R=A.
%%%%ex 24
depth([],1).
depth([H|T],R):- atomic(H), !, depth(T,R).
depth([H|T],R):- depth(H,R1), depth(T,R2), R3 is R1+1, max3(R3,R2,R).

tree3(t(4,t(2,1,nil),t(7,5,nil))).

ins_sort([H|T], R):- ins_sort(T, R1), ins_ord(H,R1,R).
ins_sort([], []).

ins_ord(X, [H|T], [H|R]):- X>H, !, ins_ord(X,T,R).
ins_ord(X, T, [X|T]).

inorder(nil, []).
inorder(t(K,L,R),Res):- inorder(L,LL), inorder(R,LR), append(LL,[K|LR],Res).

sort_1(nil,L,L).
sort_1(n(Left,Key,Right),Lin,Lout):-
sort_1(Left,Lin,Llout),
append(Llout,[Key],Lrin),
sort_1(Right,Lrin,Lout).
sort_1(Tree,Result):-
sort_1(Tree,[],Result).

%%%ex25
flatten([], []).
flatten([H|T], [H|R]):- atomic(H), !, flatten(T,R).
flatten([H|T], R):- flatten(H, R1), flatten(T, R2), append(R1, R2, R).

%%%%flatten with difference list
flatten_dl([], First, Last):- !, First=Last.
flatten_dl(H, First, Last):- atomic(H), !, First=[H|Last].
flatten_dl([H|T], First, Last):- atomic(H), !, First=[H|FirstT],
								 flatten_dl(T, FirstT, LastT),
								 Last=LastT.
flatten_dl([H|T], First, Last):- flatten_dl(H, First1, Last1),
								 flatten_dl(T, First2, Last2),
								 First=First1, 
								 Last1 = First2,
								 Last=Last2.
								 


replace_all2(_,_,[],[]):-!.
replace_all2(X,Y,[X|T],[Y|R]):- atomic(X),!,replace_all2(X, Y, T, R).
replace_all2(X,Y,[H|T],[H|R]):- atomic(H),!,replace_all2(X, Y, T, R).
replace_all2(X,Y,[H|T],R):-  not(atomic(H)),!,replace_all2(X, Y, H, R1), replace_all2(X,Y,T,R2), append(R1,R2,R).


%%delete_key
delete_key(Key, t(Key, L, nil), L):-!.
delete_key(Key, t(Key, nil, R), R):-!.
delete_key(Key, t(Key, L, R), t(Pred,NL,R)):-!,get_pred(L,Pred,NL).
delete_key(Key, t(K,L,R), t(K,NL,R)):-Key<K,!,delete_key(Key,L,NL).
delete_key(Key, t(K,L,R), t(K,L,NR)):-delete_key(Key,R,NR).


% caută nodul predecesor
get_pred(t(Pred, L, nil), Pred, L):-!.
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-get_pred(R, Pred, NR).

tree(t(6, t(4, t(2, nil, nil), t(5, nil, nil)), t(9, t(7, nil, nil), nil))).
 
likes(bill,wine).
likes(dick,beer).
likes(harry,beer).
likes(john,beer).
likes(peter,wine).
likes(tom,beer).



%%%%%%%%quicksort with difference lists
partition(X,[H|T], [H|Left], Right):- H<X, !, partition(X,T,Left,Right).
partition(X, [H|T], Left, [H|Right]):- partition(X, T, Left, Right).
partition(_, [], [], []).

quicksort_dl([H|T], LStart, LEnd):- partition(H,T,Left,Right),
									quicksort_dl(Left,LLStart,LLEnd),
									quicksort_dl(Right,LRStart, LREnd),
									LStart = LLStart,
									LLEnd = [H|LRStart],
									LEnd=LREnd.
quicksort_dl([], L, L).	


%%%append de liste
append2([],L,L).
append2([H|T], L, [H|R]):- append2(T,L,R). 			

append3([],[],L,L).
append3([H1|T1], L2, L3,[H1|Res]):-	append3(T1,L2,L3,Res).
append3([], [H2|T2], L3, [H2|Res]):- append3([], T2, L3, Res).

delete2(H, [H|T], T).
delete2(X,[H|T],[H|R]):- delete2(X,T,R).	

member2(H, [H|_]):-!.
member2(X, [_|T]):- member2(X,T).



%%%%%%%%%?Cond de oprire
remove_duplicates([X|R1], L):- member2(X, R1), remove_duplicates(R1, L).
remove_duplicates([X|R1], [X|R]):- remove_duplicates(R1, R).
remove_duplicates([H|_], L):-var(L), !, L=[H|_].

s([H|T], L, [H|R]):-write(H),s(T,L,R).
s([], R, R).

one_pass([H1,H2|T], [H1|R]):- H1=<H2, !, one_pass([H2|T],R).
one_pass([H1,H2|T], [H2|R]):-one_pass([H1|T],R).
one_pass([H1],[H1]).
one_pass([],[]).

rep(_, [], _, []).
rep(X, [X|T], Y, [Y|R]):- rep(X, T, Y, R).
rep(X, [H|T], Y, [H|R]):- rep(X, T, Y, R).

delete_all(X, [X|T], R):- !,delete_all(X,T,R).
delete_all(X,[H|T],[H|R]):-delete_all(X,T,R).
delete_all(_,[],[]).

sort_decreasing(In, Out):- helper(X, [A,B|Y], In),
							A<B, !,
							helper(X,[B,A|Y], Int),
							sort_decreasing(Int, Out).
sort_decreasing(In, In).

helper([], L, L).
helper([H|T], L, [H|R]):- helper(T,L,R).

count_duplicates([H|T], C):- m(H,T),!,
							 d(H,T,RI),
							 count_duplicates(RI,CI),
							 C is CI+1.
count_duplicates([_|T], C):- count_duplicates(T,C).
count_duplicates([], 0).

d(_, [], []).
d(H, [H|T], R):- !, d(H,T,R).
d(X,[H|T],[H|R]):-d(X,T,R).

m(X,[X|_]):-!.
m(X,[_|T]):-m(X,T).




