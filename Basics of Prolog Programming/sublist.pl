/************************************************************************
Name	: Melita Saldanha
SBU ID	: 112551230
Course	: CSE 505 - Computing with Logic

Ques 3	: Delete an element from a list non-deterministically.
************************************************************************/

sublist([],_).

sublist([H|T1],[H|T2]):-
	algo(T1,T2); 
	sublist([H|T1],T2).

sublist([H1|T1],[H2|T2]):-
	sublist([H1|T1],T2).

algo([],L).
algo([H|T1],[H|T2]):-
	algo(T1,T2).

/****************************
OR

append([],L2,L2).
append([H|T], L2, [H|Temp]) :-
	append(T, L2, Temp).

append([a,b,c],[d,e,f],L3).

sublist(S,L) :-
	append(L1,L2,L),
	append(S,L3,L2).
***************************/