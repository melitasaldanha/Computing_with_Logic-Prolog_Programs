/************************************************************************
Name	: Melita Saldanha
Course	: CSE 505 - Computing with Logic

Ques 3	: Find if list L1 is a sublist of list L2.
************************************************************************/

% Base Case - An empty list is always a sublist
sublist([],_).

% If first element of the list matches the first element of sublist
% Call checkSublist - To check if entire sublist matches
% If not, traverse the list further and start checking for first element again 
sublist([H|T1],[H|T2]):-
	checkSublist(T1,T2); 
	sublist([H|T1],T2).

% If first element of a list does not match the first element of sublist
% Traverse the list further
sublist([H1|T1],[_|T2]):-
	sublist([H1|T1],T2).

% All elements of sublist has been checked - Return the remaining list as it is
checkSublist([],_).

% Recursion - Traverse remaining list to check if entire sublist matches
checkSublist([H|T1],[H|T2]):-
	checkSublist(T1,T2).

/************************************************************************
OUTPUT:
?- sublist([a,b],[a,b,c,d]).
yes

?- sublist([b,c],[a,b,c,d]).
yes

?- sublist([],[a,b,c,d]).
yes

?- sublist([b,d],[a,b,c,d]).
no

?- sublist([a,b,c,d], [a,b]).
no

?- sublist([e],[a,b,c,d]).
no
************************************************************************/