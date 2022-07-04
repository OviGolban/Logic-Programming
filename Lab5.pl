



member1(X, [X|_]).
member1(X, [_|T]) :- member1(X, T).

min1([H|T], M):- min1(T, M), M<H, !.
min1([H|_], H).

max1([H|T], M):- max1(T, M), M>H, !.
max1([H|_], H).

delete1(X, [X|T], T):-!. % șterge prima apariție și se oprește
delete1(X, [H|T], [H|R]) :- delete1(X, T, R). % altfel iterează peste elementele listei
delete1(_, [], []). % daca a ajuns la lista vida înseamnă că elementul nu a fost găsit și putem returna lista vidă


ins_sort([H|T], R):- ins_sort(T, R1), insert_ord(H, R1, R).
ins_sort([], []).

insert_ord(X, [H|T], [H|R]):-X>H, !, insert_ord(X, T, R).
insert_ord(X, T, [X|T]).

bubble_sort(L,R):-one_pass(L,R1,F), nonvar(F), !, bubble_sort(R1,R).
bubble_sort(L,L). 


quick_sort([H|T], R):- % alegem pivot primul element
partition(H, T, Sm, Lg), 
quick_sort(Sm, SmS), % sortam sublista cu elementele mai mici decât pivotul
quick_sort(Lg, LgS), % sortam sublista cu elementele mai maridecât pivotul
append(SmS, [H|LgS], R).
quick_sort([], []).
partition(H, [X|T], [X|Sm], Lg):-X<H, !, partition(H, T, Sm, Lg).
partition(H, [X|T], Sm, [X|Lg]):-partition(H, T, Sm, Lg).
partition(_, [], [], []).

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

length1([], 0).
length1([_|T], Len) :- length1(T, Lcoada), Len is 1+Lcoada.


%%%%%%%%%%%%%%%%%%%ex1
perm1([],[]).
perm1(L, [X|R]):- member1(X, L), delete1(X, L, D), perm1(D, R).


one_pass([H1,H2|T], [H2|R], F):-H1>H2, !, F=1, one_pass([H1|T],R,F).
one_pass([H1|T], [H1|R], F):-one_pass(T, R, F).
one_pass([], [] ,_).



%%%%%%%%%%%%%%%%%%ex2
sel_sort(L, [M|R]):- min1(L, M), delete1(M, L, L1), sel_sort(L1, R).
sel_sort([], []).

sel_sort2(L, [M|R]):- max1(L, M), delete1(M, L, L1), sel_sort2(L1, R).
sel_sort2([], []).


%%%%%%%%%%%%%%%%ex3

ascii([H|T],R):- char_code(H,R1), ascii(T,Rint), R=[R1|Rint].
ascii([],[]).

characters(R,[H|T]):- char_code(Rint,H), characters(R1, T), R=[Rint|R1].
characters([],[]).

sort_chars(L,R):- ascii(L,Rint), merge_sort(Rint, Rnou), characters(R,Rnou).
sort_chars([],[]).




%%%%%%%%%%%%%%%ex4









