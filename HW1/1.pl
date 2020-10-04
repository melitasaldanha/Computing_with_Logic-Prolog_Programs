/*******************************************************************
Name	: Melita Saldanha
Course	: CSE 505 - Computing with Logic

Ques 1	: Splitting a list into 2 lists with odd and even elements.
********************************************************************/

% Main
split(L, L1, L2):-
	checkOE(L, L1, L2, 1).

% Base Case
checkOE([],[],[],_).

% Odd
checkOE([H|T],[H|L1],L2, 1) :-
	checkOE(T,L1,L2, 0).

% Even
checkOE([H|T],L1,[H|L2], 0) :-
	checkOE(T,L1,L2, 1).

/******************************************************************
OUTPUT:
?- split([a,b,c,d],L1,L2).
L1 = [a,c]
L2 = [b,d]
yes

?- split([a,b,c,d,e],L1,L2).
L1 = [a,c,e]
L2 = [b,d]
yes

?- split([],L1,L2).
L1 = []
L2 = []
yes
******************************************************************/