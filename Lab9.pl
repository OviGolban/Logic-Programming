tree3(t(3, t(4,t(2,nil,nil),t(5,nil,nil)), t(9,t(7,nil,nil),nil))).

add2(X, LS, LE, RS, RE):- RS = LS, LE = [X|RE].
% variabila de la finalul listei va conține pe prima poziție elementul de adăugat

append_dl(LS1, LE1, LS2, LE2, RS, RE):- RS=LS1, LE1=LS2, RE=LE2.

delete1(X, [X|T], T):-!. % șterge prima apariție și se oprește
delete1(X, [H|T], [H|R]) :- delete1(X, T, R). % altfel iterează peste elementele listei
delete1(_, [], []). % daca a ajuns la lista vida înseamnă că elementul nu a fost găsit și putem returna lista vidă

member1(X, [X|_]).
member1(X, [_|T]) :- member1(X, T).

perm1([],[]).
perm1(L, [X|R]):- member1(X, L), delete1(X, L, D), perm1(D, R).

all_perm(L,_):- perm1(L,L1), % predicatul de generare a unei permutări (vezi lucrare de laborator cu sortări)
				assertz(p(L1)),
				fail.
all_perm(_,R):- collect_perms(R).
collect_perms([L1|R]):- retract(p(L1)), !, collect_perms(R).
collect_perms([]).


%append2([], L, L):- !.
%append2([H|T], L2, [H|CoadaR]) :- append2(T, L2, CoadaR).

append2([], L2, R) :- R=L2.
append2([H|T], L2, R) :- append2(T, L2, CoadaR), R=[H|CoadaR].


%%%%%%%%%%%%%%ex1
%%%incompl to diff
convert_ITDiff([H|_], LE, LE):- var(H),!.
convert_ITDiff([H|LS], LE, [H|Res]):- convert_ITDiff(LS, LE, Res).

%%%diff to incompl
dTIncompl(LE, LE, _):- var(LE), !.
dTIncompl([H|LS], LE, [H|Res]):- dTIncompl(LS, LE, Res).


%%%%%%%%%%%%%%%ex2
%%%compl to diff
convert_tDiff([], R, R).
convert_tDiff([H|T], LE, [H|LS]):- convert_tDiff(T,LE,LS).


%%diff to compl
convert_tCompl(LE, LE, []):- var(LE), !.
convert_tCompl([H|LS], LE, [H|Res]):- convert_tCompl(LS, LE, Res).


%%%%%%%%%%%????ex3
all_decomposition(X,Y,Res):-append2(X,Y,Res).


%%%%%%%%%%%%ex4
flat_dl([],LS,LS).
flat_dl([H|T], [H|LS], LE):- atomic(H), !, flat_dl(T, LS, LE).
flat_dl([H|T], LS, LE):- flat_dl(H,LS1, LE1), flat_dl(T,LS2, LE2), LS=LS1, LE1=LS2, LE=LE2.



%%%%%%%%%%%ex5
collect(nil, LS, LS).
collect(t(K,L,R), LS, LE):- X is K mod 2, X \= 0, collect(L, LS1, LE1), collect(R, LS2, LE2), LS=LS1, LE1 = LS2, LS = LE2 .
collect(t(K,L,R), [K|LS], LE):- collect(L, LS1, LE1), collect(R, LS2, LE2), LS=LS1, LE1=LS2, LE=LS2.



%%%%%%%%%%ex6
collect_between(nil, _, _, [], []).
collect_between(t(K,L,R), K1, K2, [K|LS], LE):- K>K1, K<K2, collect_between(L,K1, K2, LS1,LE),collect_between(R,K1, K2, LS2, LE2), LS=LS1, LE1=LS2.
collect_between(t(_,L,R), K1, K2, LS, LE):- collect_between(L,K1, K2, LS1,LE1),collect_between(R, K1, K2, LS2, LE), LS=LS1, LE1=LS2.
