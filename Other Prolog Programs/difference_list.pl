/***************************************
% dappend(list1-tail1, list2-tail2, finalList-tail) - Append difference lists
dappend(X-T1, Y-T2, L-T3) :-
	T1 = Y,
	T2 = T3,
	L = X.
**************************************/

% 1. Append Difference lists: dappend(list1-tail1, list2-tail2, finalList-tail) - Simplified
dappend(X-T1, T1-T2, X-T2).

/******************************************************
%add(givenList-tail, element to be added, newList-tail)
add(H-T1, X, L-T2) :-
	T1 = [X|T2],
	L = H.

%add(givenList-tail, element to be added, sameGivenList-newTail) - Simplified
add(L-T1, X, L-T2) :-
	T1 = [X|T2].
*******************************************************/

%add(givenList-[elementAdded|newTail], element to be added, sameGivenList-newTail) - More Simplified
add(L-[X|T], X, L-T).

/********************************************************
% 2. Add new element to difference list: add(givenList-tail, element to be added, newList-tail) - Using dappend
add(H-T1, X, L-T2) :-
	dappend(H-T1, [X|T2]-T2, L-T2).
*******************************************************/

% 3. palindrome(list) - Check if list is a palindrome
palindrome(X) :-
	palindromeHelp(X-[]). % helper
	palindromeHelp(A-A).  % an empty list
palindromeHelp([_|A]-A). %1-element list
palindromeHelp([C|A]-D) :-
	B=[C|D],
	palindromeHelp(A-B).

/*****************************************
preorder(Root, List)
preorder(Node, List) :-
	preorder1(Node, List-[]).
preorder1(Node, List-Tail) :-
	node(Node, Child1, Child2),
	List = [Node|List1],
	preorder1(Child1, List1-Tail1),
	preorder1(Child2, Tail1-Tail).
preorder1(Node, [Node|Tail]-Tail) :-
	leaf(Node).
****************************************/

% preorder(Root, List) - Simplified
preorder1(Node, [Node|L]-T) :-
	node(Node, Child1, Child2),
	!,
	preorder1(Child1, L-T1),
	preorder1(Child2, T1-T).
preorder1(Node, [Node|T]-T).

% inorder(Root, list)
inorder(Node,L):-
	inorder1(Node, L-[]).
inorder1(Node, L-T) :-
	node(Node, Child1, Child2),
	!,
	inorder1(Child1, L-T1),
	T1 = [Node|T2],
	inorder1(Child2, T2-T).
inorder1(Node, [Node|T]-T).

% postorder(Root, List)
postorder(Node,L):-
	postorder1(Node, L-[]).
postorder1(Node, L-T) :-
	node(Node, Child1, Child2),
	!,
	postorder1(Child1, L-T1),
	postorder1(Child2, T1-T2),
	T2 = [Node|T].
postorder1(Node, [Node|T]-T).