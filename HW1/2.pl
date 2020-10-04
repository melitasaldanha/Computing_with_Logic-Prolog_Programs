/************************************************************************
Name	: Melita Saldanha
Course	: CSE 505 - Computing with Logic

Ques 2	: Delete an element from a list non-deterministically.
************************************************************************/

% Base Case - When element to be deleted is first element of the list
delete(X,[X|Y],Y).

% Recursion - If element to be deleted is not first element of the list
delete(X, [Y|Ys], [Y|Z]) :-
	delete(X, Ys, Z).

/************************************************************************
OUTPUT:
?- delete(a,[a,b,c],X).
X = [b,c]
yes

?- delete(a,[a,b,a,c],X).
X = [b,a,c];
X = [a,b,c];
no

?- delete(a,[b,c,d],X).
no
************************************************************************/