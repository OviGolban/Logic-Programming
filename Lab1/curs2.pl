member1(X, [X|_]).
member1(X, [_|T]):- member1(X,T).
member1(_, []):- fail.