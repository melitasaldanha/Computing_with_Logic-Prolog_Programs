/*************************************************************************
Name	 : Melita Saldanha
Course	 : CSE 505 - Computing with Logic

Homework : 2
Ques	 : Implement a proof by refutation system for propositional logic.
*************************************************************************/

% Append 2 Lists
append([],L2,L2).
append([X|L1],L2,[X|L3]):-
	append(L1,L2,L3).

% Find Clause to be Flattened and number it
flattenElementsOfList([], [], _, []) :- !.
flattenElementsOfList([X|Y], [Xnew_count|Ynew], Count, [Xnew|UniqueLiterals]) :-
	flattenOR(X, Xnew),
	Xnew_count = [Count, Xnew],
	NewCount is Count+1,
	flattenElementsOfList(Y, Ynew, NewCount, UniqueLiterals).

% Flatten the clause i.e. create list of literals (Remove or)
flattenOR([],[]).
flattenOR(or(X,Y),L) :-
	!,
	flattenOR(X, L1),
	flattenOR(Y, L2),
	append(L1, L2, L).
flattenOR(X, [X]).

% Flatten Nested Clause
flattenNested([],[]).
flattenNested([X|Y],L) :-
	!,
	flattenNested(X, L1),
	flattenNested(Y, L2),
	append(L1, L2, L).
flattenNested(X, [X]).

% Find last clause of list
findLastClause([X], X) :- !.
findLastClause([_|Xs], L) :-
	findLastClause(Xs, L).

% Negate the literal
negate(neg(Literal), Literal) :- !.
negate(Literal, neg(Literal)) :- !.

% Find if literal is a member of the clause
member(X, [X|_]).
member(X, [_|Ys]):-
	member(X,Ys).

% Delete the element from the list
deleteElement(X, [X|Xs], Xs).
deleteElement(X, [Y|Ys], [Y|L]) :-
	deleteElement(X, Ys, L).

% Delete the Clause based on its Number
deleteClauseNumber(CNT, [X|Xs], RES) :- 
	X = [Number, _],
	(
		Number=:=CNT ->
			RES = Xs;
			(
				RES = [X|NewRES],
	    		deleteClauseNumber(CNT, Xs, NewRES)
	    	)
    ).

% Check if list is empty
isEmpty([]).

% reverseFlatten (Add or) - Make List into a clause
reverseFlatten([X], X) :- !.
reverseFlatten([X, Y], or(X, Y)) :- !.
reverseFlatten([X,Y|Z], [or(X,Y)|Rem]) :-
	reverseFlatten([or(X,Y)|Z], Rem).

% Print final solution on success
printSolution([]).
printSolution([X|Xs]) :-
	write(X),
	writeln('.'),
	printSolution(Xs).

% Print if success / fail 
resolution(Solution) :- 
	(
		isEmpty(Solution),
		writeln('resolution(fail).'),
		!
	);
	(
		writeln('resolution(success).'),
		printSolution(Solution)
	).

% Main function
resolution() :-
	findall(Clause, myClause(_,Clause), ListOfAllClauses),
	appendQueryToClauses(GoalNestedList),
	append(ListOfAllClauses, GoalNestedList, FinalListOfAllClauses),
	flattenElementsOfList(FinalListOfAllClauses, FlattenedList, 1, UniqueLiterals),
	flattenNested(UniqueLiterals, FlatUniqueLiterals),
	sort(FlatUniqueLiterals, SortedLiterals),
	resolutionProcess(FlattenedList, Solution, SortedLiterals),
	resolution(Solution).

% Split Queries into Individual literals
% Flatten and negate them and create a list to append to the given clauses
appendQueryToClauses(GoalNestedList) :-
	myQuery(_, Goal),
	flattenOR(Goal, GoalList),
	makeGoalNegList(GoalList, GoalNestedList).
	
% Negate all literals in the list of queries
makeGoalNegList([], []).
makeGoalNegList([X|Y], [NegOfGoal | Rem]) :-
	negate(X, NegOfGoal),
	makeGoalNegList(Y, Rem).

% Process of resolution
resolutionProcess([_], Solution, _) :-
	Solution = [],
	!.
resolutionProcess(List, Solution, UniqueLiterals) :-
	findLastClause(List, [Count, LastClause]),
	LastClause = [FirstLiteral | _],
	negate(FirstLiteral, NegOfFirstLiteral),
	traverseListToFindNeg(NegOfFirstLiteral, List, FoundCount, FoundClause),
	(
		(
			isEmpty(FoundClause),
			Solution = [],
			!
		);
		(
			append(FoundClause, LastClause, MergedClause),
			solve(MergedClause, NewClause, UniqueLiterals, FinalLiterals),
			deleteClauseNumber(Count, List, NewTempList),
			deleteClauseNumber(FoundCount, NewTempList, ResolvedList),
			NewClauseCount is Count+1,
			(
				isEmpty(NewClause) ->
				(
					Solution = [resolution(FoundCount, Count, empty, NewClauseCount)]
				);
				(
					append(ResolvedList, [[NewClauseCount, NewClause]], NewList),
					reverseFlatten(NewClause, ReverseFlattenedClause),
					resolutionProcess(NewList, RemainingSolution, FinalLiterals),
					(
						(
							isEmpty(RemainingSolution),
							Solution = [],
							!
						);
						Solution = [resolution(FoundCount, Count, ReverseFlattenedClause, NewClauseCount)|RemainingSolution]
					)
				)
			)
		)
	).
	
% Traverse the list of Clauses to find clause number which contains negation
traverseListToFindNeg(_, [], _, FoundClause) :-
	FoundClause = [],
	!.
traverseListToFindNeg(Member, [[Count, Clause]|Y], FoundCount, FoundClause) :-
	(
		member(Member, Clause),
		FoundCount is Count,
		FoundClause = Clause,
		!
	);
	traverseListToFindNeg(Member, Y, FoundCount, FoundClause).

% Minimized merged list to remove duplicates and cancel negations
solve([], [], UniqueLiterals, UniqueLiterals) :- !.
solve(Clause, NewClause, UniqueLiterals, FinalLiterals) :-
	Clause = [X|Y],
	(
		% If X exists in the tail - Then it's a duplicate in this merged clause, Ignore X 
		% OR 
		% If X is not a member of UniqueLiterals - Then it's already been used in a previous clause, Ignore X
		(
			(
				(
					(member(X,Y), !);
					(\+ member(X, UniqueLiterals))
				) ->
					solve(Y, NewClause, UniqueLiterals, FinalLiterals)
			),
			!
		);

		% If neg(X) exists then delete both
		% Delete X and neg(X) from UniqueLiterals
		(
			negate(X, Xneg),
			member(Xneg, Y),
			deleteElement(Xneg, Y, Ynew),
			deleteElement(X, UniqueLiterals, TempUniqueLiterals),
			deleteElement(Xneg, TempUniqueLiterals, NewUniqueLiterals),
			solve(Ynew, NewClause, NewUniqueLiterals, FinalLiterals),
			!
		);

		% If neither of the above is true, keep X and check from next element
		(
			solve(Y, NewClauseOfY, UniqueLiterals, FinalLiterals),
			NewClause = [X|NewClauseOfY],
			!
		)
	).

/******************************************************
Test 1 :-

INPUT:
myClause(1, or(a_1, a_2)).
myClause(2, or(or(neg(a_2), b_2), b_3)).
myClause(3, or(neg(b_2), b_3)).
myClause(4, neg(b_3)).
myQuery(5, a_1).

OUTPUT:
resolution(success).
resolution(1,5,a_2,6).
resolution(2,6,or(b_2,b_3),7).
resolution(3,7,b_3,8).
resolution(4,8,empty,9).


Test 2 :-

INPUT:
myClause(1, or(neg(p), r)).
myClause(2, or(neg(r), s)).
myClause(3, or(neg(s), t)).
myClause(4, or(neg(t), v)).
myClause(5, or(neg(v), w)).
myClause(6, or(neg(w), u)).
myQuery(7, p).

OUTPUT:
resolution(fail).
******************************************************/