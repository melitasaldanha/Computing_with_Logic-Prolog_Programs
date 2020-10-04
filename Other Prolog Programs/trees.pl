%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required Functions:
% append(L1,L2,L3) - L3 = L1+L2
append([],L2,L2).
append([X|L1],L2,[X|L3]):-
	append(L1,L2,L3).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

node(5,3,6).
node(3,1,4).
leaf(1).
leaf(4).
leaf(6).

% 1. preorder(Root, Required Pre-order List)
preorder(X, [X]) :-
	leaf(X).
preorder(Root, [Root|L]) :-
	node(Root, Left, Right),
	preorder(Left, L1),
	preorder(Right, L2),
	append(L1, L2, L).

% 2. postorder(Root, Required Post-order List)
postorder(X, [X]) :-
	leaf(X).
postorder(Root, L) :-
	node(Root, Left, Right),
	postorder(Left, L1),
	postorder(Right, L2),
	append(L1, L2, L3),
	append(L3, [Root], L).

% 3. inorder(Root, Required Post-order List)
inorder(X, [X]) :-
	leaf(X).
inorder(Root, L) :-
	node(Root, Left, Right),
	inorder(Left, L1),
	inorder(Right, L2),
	append(L1, [Root|L2], L).