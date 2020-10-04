/***********************************
?- alice = alice.
Yes

?- 'alice' = alice.
Yes

(Not Equal: \+)
?- \+ (alice = albert).
Yes 

?- 3 >= 15.
No

(Less than or equal to: =<)
?- 3 =< 15
Yes

?- W = alice
W = alice
Yes

?- rich(money, X) = rich(Y, no_debt).
X = no_debt
Y = money
Yes

?- X is 2+2
X = 4

?- X is 3+(2*10).
X = 23

?- (3*10) >= (50/2)
Yes

(Not Equal: \+)
?- \+ (3=10)
Yes

(Equality: =:=)
?- 5+4 =:= 4+5
Yes

(Not Equal: =\=)
?- 5+4 =\= 4=5
No 

(Or: ;)
?- 5>10 ; 10<100
Yes

?- X is mod(7,2)
X = 1

?- random(0,10,X).
X = 9

?- between(0,10,X).
X = 0;
X = 1;
.
.
X = 10

(Increment value by 1)
?- succ(2,X)
X = 3

(Find Absolute)
?- X is abs(-8).
X = 8

?- X is min(10,5).
X = 

?- X is truncate(10.56).
X = 10

?- X is round(10.56).
X = 11

?- X is floor(10.56).
X = 10

?- X is ceiling(10.56).
X = 11

(Exponent: **)
?- X is 2**3.
X = 8.0

% Math Functions:
sqrt, log, log10, exp, pi, e
sin, cos, tan, asin, acos, atan, atan2,
sinh, asinh, acosh, atanh,
************************************/

double_digit(X,Y) :-
	Y is X*2.

/***********************
?- double_digit(10,Y).
Y = 20
************************/

% Divide and round off ans: /
% Divide and get ans in decimal: //
is_even(X) :-
	Y is X//2,
	X =:= 2*Y.

% Take Input
% Read a string: read()
% Read a character: get()

say_hi :-
	write('What is your name?'), nl,
	read(X),
	write('Hi '),
	write(X).

/********************
?- say_hi.
What is your name?
'Melita'.
Hi Melita
*********************/

% Use put() to print character
% Using direct write() will give it's ASCII value
get_char :-
	write('Enter a character: '),
	get(X),
	write('Character: '),
	put(X), nl,
	write('ASCII value: '),
	write(X).

/**********************
?- get_char.
Enter a character: A
Character: A
ASCII value: 65
**********************/