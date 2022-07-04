tree1(t(6, t(4,t(2,nil,nil),t(5,nil,nil)), t(9,t(7,nil,nil),nil))).
tree2(t(8, t(5, nil, t(7, nil, nil)), t(9, nil, t(11, nil, nil)))).
tree3(t(4,t(2,nil,nil,nil),t(7,nil,nil,nil),t(3,t(5, nil, nil,nil),nil,nil))).
tree4(t(7,t(2,nil,nil),t(5,nil,nil))).

pretty_print(nil, _).
pretty_print(t(K,L,R), D):-D1 is D+1,
pretty_print(L, D1), 
print_key(K, D), 
pretty_print(R, D1). 


% predicat care afișează cheia K la D tab-uri față de marginea din stânga și inserează o linie nouă
print_key(K, D):-D>0, !, D1 is D-1, write('\t'), print_key(K, D1).
print_key(K, _):-write(K), write('\n').
% write('\n') îi echivalent cu predicatul nl

inorder(t(K,L,R), List):-inorder(L,LL), inorder(R,LR), append(LL, [K|LR], List).
inorder(nil, []).

preorder(t(K,L,R), List):-preorder(L,LL), preorder(R, LR), append([K|LL], LR, List).
preorder(nil, []).
% subarbore stâng, subarbore drept și apoi cheia
postorder(t(K,L,R), List):-postorder(L,LL), postorder(R, LR), append(LL, LR,R1), append(R1, [K], List).
postorder(nil, []).


%%%%%%%%%%%%%%%%%%ex 1
preorder_t(t(K,L,M,R), List):- preorder_t(L,LL),preorder_t(M,LM),preorder_t(R, LR), append([K|LL], LM, ListInter), append(ListInter, LR, List).
preorder_t(nil, []).

inorder_t(t(K,L,M,R), List):- inorder_t(L,LL), inorder_t(M,LM),inorder_t(R,LR), append(LL, [K|LM], ListInter), append(ListInter, LR, List).
inorder_t(nil, []).

postorder_t(t(K,L,M,R), List):- postorder_t(L,LL), postorder_t(M,LM), postorder_t(R,LR),append(LL,LM,Linter), append(Linter, LR, Linter2), append(Linter2, [K], List).
postorder_t(nil, []).

delete_key(Key, t(Key, L, nil), L):-!.
delete_key(Key, t(Key, nil, R), R):-!.
delete_key(Key, t(Key, L, R), t(Pred,NL,R)):-!,get_pred(L,Pred,NL).
delete_key(Key, t(K,L,R), t(K,NL,R)):-Key<K,!,delete_key(Key,L,NL).
delete_key(Key, t(K,L,R), t(K,L,NR)):-delete_key(Key,R,NR).

% caută nodul predecesor
get_pred(t(Pred, L, nil), Pred, L):-!.
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-get_pred(R, Pred, NR).

max(E1,E2,R):- E1 > E2,! , R is E1.
max(_,E2,R):- R is E2.

height(nil, 0).
height(t(_, L, R), H):-height(L, H1), 
					height(R, H2),
					max(H1, H2, H3), 
					H is H3+1.


%%%%%%%%%%%%ex2
height_t(nil, 0).
height_t(t(_,L, M, R), H):- height_t(L, H1),
						height_t(M, H2),
						height_t(R, H3),
						max(H1, H2, Hn),
						max(H3, Hn, Hf),
						%%writeln(Hf),
						H is Hf+1.


%%%%%%%%%ex3						
delete_key_succ(Key, t(Key, L, nil), L):- !.
delete_key_succ(Key, t(Key, nil, R), R):- !.
delete_key_succ(Key, t(Key, L, R), t(Succ, L, NR)):- !, get_succ(R, Succ, NR).
delete_key_succ(Key, t(K,L,R), t(K,NL,R)):-Key<K,!,delete_key_succ(Key,L,NL).
delete_key_succ(Key, t(K,L,R), t(K,L,NR)):-delete_key_succ(Key,R,NR).

get_succ(t(Succ, R, nil), Succ, R):- !.
get_succ(t(Key, L, R), Succ, t(Key, R, NL)):- get_succ(L, Succ, NL).


%%%%%%%%%%ex4
leaves(nil, []).
leaves(t(Key, nil, nil), Key).
leaves(t(_, L, nil), Res):- leaves(L, Res).
leaves(t(_, R, nil), Res):- leaves(R, Res).
leaves(t(_,L,R), [K1,K2|[]]):- leaves(L,K1), leaves(R,K2).



%%%%%%%%%ex5
diam(nil, 0).
diam(t(_, L, R), D):- diam(L, D1), diam(R, D2), height(L, H1), height(R, H2), H3 is H2+H1+1 , max(D1,D2,D3), max(D3,H3,D).
