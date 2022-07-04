node(a). node(b). node(c). node(c). node(d). node(e). node(f). node(g). node(h). %etc
edge(a,b). edge(b,a).
edge(b,c). edge(c,b).
edge(a,d). edge(d,a).
edge(b,d). edge(d,b).
edge(d,c). edge(c,d).

edge(e,g). edge(g,e).
edge(e,f). edge(f,e).

%%neighbor(a, [b, d]).
%%neighbor(b, [a, c, d]).
%%neighbor(c, [b, d]).
%%neighbor(h, []).

:-dynamic neighbor/2. % declarăm predicatul dinamic pentru a putea folosi retract

%%%%%%%%%%%%%%ex1
neighb_to_edge:-retract(neighbor(Node,List)),!, %extrage un predicat neighbor și apoi îl procesează
process(Node,List),
neighb_to_edge.
neighb_to_edge. % daca nu mai sunt predicate neighbor înseamnă că am terminat
% procesarea presupune adăugare de predicate edge și node pentru un predicat neighbor
process(Node, [H|T]):- assertz(edge(Node, H)), process(Node, T).
process(Node, []):- assertz(node(Node)).


edge_to_neigbh:- retract(edge(X,Y)), 
				 !,
				 edge_to_neighb.
edge_to_neighb.	

process2(X, Y):- retract(neighbor(X, R)), !, assert(neighbor(X, [Y|R])).
process2(X, Y):- assert(neighbor(X, [Y])).



%%%%%%%%%%%%%%%%ex2
% hamilton(NumOfNodes, Source, Path)
hamilton(NN, X, Path):- NN1 is NN-1, hamilton_path(NN1,X, X, [X],Path).	
hamilton_path(0,X,X,PPath, PPath):- !.
hamilton_path(NN, X,Y,PPath, FPath):- NN1 is NN-1, edge(X,Z),(NN1 = 0;not(member(Z, PPath))),
										hamilton_path(NN1, Z, Y, [Z|PPath], FPath).
% path(Source, Target, Path)
path(X,Y,Path):-path(X,Y,[X],Path). % drumul parțial începe cu punctul de pornire
path(Y,Y,PPath, PPath). % când ținta este egală cu sursa am terminat
path(X,Y,PPath, FPath):-
edge(X,Z), % căutăm o muchie
not(member(Z, PPath)), % care nu a mai fost parcursă
path(Z, Y, [Z|PPath], FPath). % și o adăugăm în rezultatul parțial



%%%%%%%%%%%%%%%%%%%%%%%%%ex3
edge(a,b,5). edge(b,a,5).
edge(a,d,2). edge(d,a,2).
edge(d,c,2). edge(c,d,2).
edge(b,d,1). edge(d,b,1).
edge(b,c,1). edge(c,b,1).

edge(g,e,2). edge(e,g,2).
edge(e,f,1). edge(f,e,1).
edge(g,f,4). edge(f,g,4).	
									
% optimal_path(Source, Target, Path) -->optimal path cu pondere
optimal_path2(X,Y,Path):-asserta(sol_part([],100)), % distanța maximă inițială
path_ponderat(X,Y,[X],Path,1).
optimal_path2(_,_,Path):-retract(sol_part(Path,_)).
path_ponderat(Y,Y,Path,Path,LPath):- % când ținta este egală cu sursa, salvăm soluția curentă
							retract(sol_part(_,_)),!,
							asserta(sol_part(Path,LPath)),
							fail. % și căutăm o altă soluție
path_ponderat(X,Y,PPath,FPath,LPath):-
							edge(X,Z,Weight),
							not(member(Z,PPath)),
							LPath1 is LPath+Weight, % calculăm distanța parțială
							sol_part(_,Lopt), % extragem distanța de la soluția precedentă
							LPath1<Lopt, % dacă distanța curentă nu depășește distanța precedentă mergem mai departe
							path_ponderat(Z,Y,[Z|PPath],FPath,LPath1).



%%%%%%%%%%%%%%%%%%ex4							
length2([],0).
length2([_|T], R):- length2(T,R1), R is R1+1. 

cycle(X,[X|R]):-edge(X, Y), path(Y,X,Res1), length2(Res1, Len), Len>2, reverse(Res1,R).
cycle(_,[]).