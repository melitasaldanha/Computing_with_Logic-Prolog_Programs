% 1. goldbach(Number to be found, List of 2 prime nos which give the number)

isPrime(2).
isPrime(3).
isPrime(N) :-
	N>3,
	N mod 2 =\= 0,
	\+ has_factor(N, 3).

has_factor(N, F) :-
	N mod F =:= 0.
has_factor(N, F) :-
	F*F < N,
	F1 is F+2,
	has_factor(N, F1).

goldbach(4, [2,2]) :- !.
goldbach(N, L) :-
	N>4,
	N mod 2 =:= 0,
	goldbach(N, L, 3).

goldbach(N, [P,Q], P) :-
	Q is N-P,
	isPrime(Q).
goldbach(N, L, P) :-
	P<N,
	!,
	nextPrime(P, P1),
	goldbach(N, L, P1).

nextPrime(P, P1) :-
	P1 is P+2,
	isPrime(P1),
	!.
nextPrime(P, P1) :-
	P2 is P+2,
	nextPrime(P2, P1).


% 2. color(graph, colors, nodes with color) - Colour the nodes of a graph s.t. adjacent nodes have different colours
:- import member/2 from basics.
% color/3
% color(graph(+Nodes,+Edges),+Colors,MapNodes).
% ?- color(graph([a,b,c],[e(a,b),e(b,c),e(c,a)]),[red,blue,green],M).
% M = [(1,red),(2,blue),(3,green)]).
color(G,C,M):-
	color_h(G,C,[],M).
color_h(graph([],_),_,_,[]).
color_h(graph([N1|TN],Es),Colors,PreviousMap,[(N1,C)|RM]):-
	member(C,Colors),
	\+((
		(member(e(N1,N2),Es);member(e(N2,N1),Es)),
		member((N2,C),PreviousMap)
	)),
	color_h(graph(TN,Es),Colors,[(N1,C)|PreviousMap], RM).


% 3. gcd(List of numbers, GCD of all numbers)
gcd([H], H).
gcd([H1,H2|T], D) :-
	gcd(H1, H2, D1),
	gcd([D1|T], D).

gcd(0, X, X) :-
	X>0,
	!.
gcd(X, Y, D) :-
	X>=Y,
	X1 is X-Y,
	gcd(X1, Y, D).
gcd(X, Y, D) :-
	Y>X,
	Y1 is Y-X,
	gcd(X, Y1, D).