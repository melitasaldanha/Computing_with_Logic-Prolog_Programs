%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required Functions:
% member(X,Y) - X is a member of list Y
member(X, [X|_]).
member(X, [_|Ys]):-
	member(X,Ys).

% length(L, M) - length(L) = M
length([],0).
length([_|Xs],M):-
	length(Xs,N),
	M is N+1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. adjacent(node X, node Y, graph(Nodes, Edges)) - Are nodes X and Y adjacent
adjacent(X, Y, graph(_,Es)) :-
	member(e(X,Y), Es);
	member(e(Y,X), Es).

% 2. path(graph, source node, dest node, path)
path(G,A,B,P) :-
	pathHelper(G,A,[B],P).
pathHelper(_,A,[A|P1],[A|P1]).
pathHelper(G,A,[Y|P1],P) :-
	adjacent(X,Y,G),
	\+ member(X,[Y|P1]),
	pathHelper(G,A,[X,Y|P1],P).

% 3. cycle(graph, source node, path of cycle from A to A)
cycle(G,A,Cycle) :-
	adjacent(A,B,G),
	path(G,B,A,P1),
	Cycle = [A|P1].

% 4. degree(Edges, node, degree of node)
degree(graph(_,Es),N,D) :-
	findall(Y, (member(e(N,Y),Es);member(e(Y,N),Es)), L),
	length(L,D).

% 5. sortByDegree(graph G, List of degrees of all nodes in sorted order)
sortByDegree(G,L) :-
	G = graph(Nodes,_Edges),
	findDegrees(G,Nodes,NodeDegrees),
	sortNodesByDegree(NodeDegrees,L).

findDegrees(_,[],[]).
findDegrees(G,[N|T],[degree(N,D)|T2]):-
	degree(G,N,D),
	findDegrees(G,T,T2).

sortNodesByDegree([],[]).
sortNodesByDegree(NodeDegrees, [Min|T]) :-
	minDegree(NodeDegrees, Min),
	select(Min, NodeDegrees, Rest),
	sortNodesByDegree(Rest, T).

minDegree([degree(N,D)|NodeDegrees], Min) :-
	minDegreeHelper(NodeDegrees, degree(N,D), Min).
minDegreeHelper([], Min, Min).
minDegreeHelper([degree(_N2,D2)|NodeDegrees], degree(N,D), Min):-
	D < D2,
	!,
	minDegreeHelper(NodeDegrees, degree(N,D), Min).
minDegreeHelper([degree(N2,D2)|NodeDegrees], _, Min):-
	minDegreeHelper(NodeDegrees, degree(N2,D2), Min).

select(X, [X|Ys], Ys).
select(X, [Y|Ys], [Y|Zs]) :-
	select(X, Ys, Zs).