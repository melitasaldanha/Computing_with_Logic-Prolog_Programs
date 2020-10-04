/************************************************************************
Name	: Melita Saldanha
Course	: CSE 505 - Computing with Logic

Ques 4	: Delete a sublist L1 from list L2 to give list L3
************************************************************************/

% Base Case - If sublist required is empty, return list as it is
delete_sublist([],L,L).

% If first element of list and sublist is same
% Check if entire sublist is present
% If yes, then delete the sublist
delete_sublist([H|T1],[H|T2],L3):-
	checkSublist(T1,T2),
	deleteSublist(T1,T2,L3).

% Recursion - If first element of list and sublist is not the same
% Traverse the list further to check next element 
delete_sublist([H1|T1],[H2|T2],[H2|L3]):-
	delete_sublist([H1|T1],T2,L3).

% Check if entire sublist is present
checkSublist([],L).
checkSublist([H|T1],[H|T2]):-
	checkSublist(T1,T2).

% Delete the sublist
deleteSublist([],L,L).
deleteSublist([H|T1],[H|T2],Y):-
	deleteSublist(T1,T2,Y).

/************************************************************************
OUTPUT:
?- delete_sublist([b,c],[a,b,c,d],X).
X = [a,d]
yes

?- delete_sublist([b,c],[a,b,c,b,d,c,a,b,c],X).
X = [a,b,d,c,a,b,c];
X = [a,b,c,b,d,c,a];
no

?- delete_sublist([b,c],[a,b,a,c,b,d,c,a,b],X).
no
************************************************************************/