%predicatul woman/1
woman(ana).
woman(sara).
woman(ema).
woman(maria).
woman(carmen).
woman(dorina).
woman(irina).

%predicatul man/1
man(andrei).
man(george).
man(alex).
man(marius).
man(mihai).
man(sergiu).

%predicatul parent/2
parent(maria, ana).
parent(george, ana).
parent(maria, andrei).
parent(george, andrei).
parent(carmen, sara).
parent(alex, sara).
parent(carmen, ema).
parent(alex, ema).
parent(marius, maria).
parent(dorina, maria).
parent(mihai, george).
parent(mihai, carmen).
parent(irina, george).
parent(irina, carmen).

%predicatul mother/2
mother(X,Y):- woman(X), parent(X,Y).
%X este mama lui Y, daca X este femeie si X este parintele lui Y

%predicatul father/2
father(X,Y):- man(X), parent(X,Y).
%X este tatal lui Y, daca X este barbat si X este parintele lui Y

% Predicatul sibling/2
% X și Y sunt frați/surori dacă au același parinte și X diferit de Y
sibling(X,Y):- parent(Z,X), parent(Z,Y), X\=Y.

% Predicatul sister/2
% X este sora lui Y dacă X este femeie și X și Y sunt frați/surori
sister(X,Y) :- sibling(X,Y), woman(X).

% Predicatul brother/2
% X este fratele lui Y dacă X este barbat și X și Y sunt frați/surori
brother(X,Y) :- sibling(X,Y), man(X).

%predicatul aunt/2
aunt(X,Y):- sister(X,Z), parent(Z,Y).

%predicatul uncle/2
uncle(X,Y):- brother(X,Z), parent(Z,Y).

%predicatul grandmother
% X este bunica lui Y, daca X este femeie si X este parintele lui Z, iar(si) Z este parintele lui Y
grandmother(X,Y):- woman(X), parent(X,Z), parent(Z,Y).

%predicatul grandfather
grandfather(X,Y):- man(X), parent(X,Z), parent(Z,Y).

%predicatul ancestor/2, ex 4.8

ancestor(X,Y):- parent(X,Z), ancestor(Z,Y).
ancestor(X,Y):-parent(X,Y).