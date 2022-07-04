edge(1,5).
edge(5,1).
edge(1,2).
edge(2,1).
edge(2,5).
edge(5,2).
edge(2,3).
edge(3,2).
edge(3,4).
edge(4,3).
edge(5,4).
edge(4,5).
edge(4,6).
edge(6,4).


:- dynamic nod_vizitat/1.
% d_search(Source, Path)
d_search(X,_):-df_search(X,_). % parcurgerea nodurilor
d_search(_,L):-!, collect_reverse([],L). % colectarea rezultatelor
df_search(X,L):-asserta(nod_vizitat(X)),
				edge(X,Y),
				not(nod_vizitat(Y)),
				df_search(Y,L).
% colectarea se face în ordine inversa
collect_reverse(L,P):-retract(nod_vizitat(X)), !, 
					  collect_reverse([X|L],P).
					  collect_reverse(L,L).

% b_search(Source, Path)
b_search(X,_):- % parcurgerea nodurilor
				assertz(nod_vizitat(X)),
				assertz(nod_de_expandat(X)),
				bf_search.
b_search(_,R):-!, collect_reverse([],R). % colectarea rezultatelor
bf_search:-retract(nod_de_expandat(X)),
			expand(X),!,
			bf_search.
expand(X):-edge(X,Y),
			not(nod_vizitat(Y)),
			asserta(nod_vizitat(Y)),
			assertz(nod_de_expandat(Y)),
			fail.
expand(_).


%%%%%%%%%%%%%%%ex1
%% depth search limited - DSL
dls(X, Y, _):- dl_search(X,Y,0,_).
dls(_, _, L):-!, collect_reverse([], L).

dl_search(X, D, Z, L) :- Z < D, !, Z1 is Z+1, asserta(nod_vizitat(X)), edge(X, Y), not(nod_vizitat(Y)), dl_search(Y, D, Z1, L).



