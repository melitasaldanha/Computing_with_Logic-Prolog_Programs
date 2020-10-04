/************************************************************************
Name	: Melita Saldanha
Course	: CSE 505 - Computing with Logic

Ques 6	: Given the denominations available and the change amount, computes the ways in which we can give change.
************************************************************************/

% Initial Case - After performing S//H1
reduce_count(X, X) :- X>=0.

% Keep reducing count to try all possibilities of a particular denomination until we reach zero
% Then current denomination is considered 0 and permutations of next denominations are tried
reduce_count(X, Y) :-
    X>0,
    reduce_count(X, Z),
    (
        Z=1, Y=0, ! ;
        Y is Z-1
    ).

% When D = [], S = 0,
change([], 0, []).

% When remaining amount in S = 0, 
% We will require 0 coins of all remaining denominations in D 
% Trace the list C further and put all remaining count = 0
change([H1|T1], 0, [H2|T2]) :- 
	H2 is 0, 
	change(T1, 0, T2).

% Start the first denomination and find count 
% Traverse to get a combination
change([H1|T1], S, [H2|T2]) :-
 	S > 0,
 	Div is S//H1,
 	reduce_count(Div,K),
	Snew is (S-(H1*K)),
	change(T1, Snew, T2),
	H2 is K.

/***********************************************
OUTPUT:
?- change([25,11,3],26,C).
C = [0, 1, 5]

?- change([25,12,3],26,C).
no

?- change([5,2,1],8,C).
C = [1,1,1];
C = [1,0,3];
C = [0,4,0];
C = [0,3,2];
C = [0,2,4];
C = [0,1,6];
C = [0,0,8];
no
***********************************************/