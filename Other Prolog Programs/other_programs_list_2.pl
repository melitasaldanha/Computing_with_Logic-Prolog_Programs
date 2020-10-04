%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required Functions:
% append(L1,L2,L3) - L3 = L1+L2
append([],L2,L2).
append([X|L1],L2,[X|L3]):-
	append(L1,L2,L3).

% length(L, M) - length(L) = M
length([],0).
length([_|Xs],M):-
	length(Xs,N),
	M is N+1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. last(list, lastElement)
last([], 0).
last([X], X).
last([_|Xs], L) :-
	last(Xs, L).

% Extra - lastButOne(list, secondLastElement)
lastButOne([X,_], X).
lastButOne([_|Xs], L) :-
	lastButOne(Xs, L).

% 2. kth(list, K, kthElement)
kth([], _, 0).
kth([X|Xs], 1, X).
kth([X|Xs], K, E) :-
	K>1,
	K1 is K-1,
	kth(Xs, K1, E).

/*******************************************
% 3. reverse(GivenList, ReversedList) - More Complexity
reverse([],[]).
reverse([X|Xs], Y) :-
	reverse(Xs, Z),
	append(Z, [X], Y).
********************************************/

% 3. reverse(GivenList, ReversedList) - Less Complexity
reverse(L,R) :-
	reverseHelper(L,[],R).
reverseHelper([],Acc,Acc).
reverseHelper([X|Xs],Acc,R) :-
	reverseHelper(Xs,[X|Acc],R).

% 4. palindrome(X) - Check is X is a palindrome
palindrome(X):-
	reverse(X,X).

% 5. flatten(nestedList, flatList)
flatten([],[]).
flatten([X|Xs],L) :-
	!,
	flatten(X, L1),
	flatten(Xs, L2),
	append(L1, L2, L).
flatten(X, [X]).

% 6. eliminateConsecutiveDuplicates(GivenList, FinalList) = compress
compress([X], [X]).
compress([X,X|T], R) :-
	compress([X|T], R),
	!.
compress([X|T], [X|R]) :-
	compress(T, R).

% 7. pack(Given List with Duplicate Elements, Result - Nested List with consecutive elements as lists)
pack([],[]).
pack([X],[[X]]).
pack([H,H|Hs], [[H|T0]|L]) :-
	pack([H|Hs], [T0|L]),
	!.
pack([H|T], [[H]|L]) :-
	pack(T, L).

% 8. encode(List with consecutive values, List of (Length, Value) of consecutive elements)
encode(L, E) :-
	pack(L, P),
	encodeHelper(P, E).

encodeHelper([], []).
encodeHelper([H|T1], [(L,X)|T2]) :-
	length(H, L),
	H = [X|_],
	encodeHelper(T1, T2).

% 9. decode(Encoded list (Length, Value), Decompressed list)
decode([], []).
decode([(L,X)|T], Y) :-
	decodeHelper(L, X, Y1),
	decode(T, Y2),
	append(Y1, Y2, Y).

decodeHelper(1, X, [X]) :- !.
decodeHelper(L, X, [X|Y1]) :-
	L1 is L-1,
	decodeHelper(L1, X, Y1).

% 10. range(lower limit, higher limit, list of integers in this range)
range(N,N,[N]).
range(L,H,[L|X]) :-
	L1 is L+1,
	L1 =< H,
	range(L1,H,X).