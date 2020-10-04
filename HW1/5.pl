/************************************************************************
Name	: Melita Saldanha
Course	: CSE 505 - Computing with Logic

Ques 5	: Flatten list L1 to get list L2.
Reference : Prolog Programming for Artificial Intelligence (By Ivan Bratko)
************************************************************************/
% Append L2 to L1, to get L3
append([], L, L).
append([X|L], M, [X|N]) :-
	append(L, M, N).

% Base Case - If list is empty, return empty
flatten([], []) :- !.

% Get head of list
% Recursion - Flatten head and tail
flatten([L|Ls], FlatL) :-
    !,
    flatten(L, NewL),
    flatten(Ls, NewLs),
    append(NewL, NewLs, FlatL).

% When single element remains, make it into a list
% Later list will be reqiured for append (Append 2 lists)
flatten(L, [L]).

/***********************************************************************
OUTPUT:
?- flatten([[a,b],[a,c],d,[e,f]], X).
X = [a,b,a,c,d,e,f]
yes

?- flatten([[a,b,[c,d,[e,f]]],[a],[[c]]], X).
X = [a,b,c,d,e,f,a,c]
yes
***********************************************************************/