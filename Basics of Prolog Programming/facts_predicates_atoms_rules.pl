% Fact: (Has predicates & atoms/vars)
% male - Predicate
% james - Atom (Start with Lower Case)
% X - Variable (Start with Upper Case or _)
male(james).
male(philip).

happy(albert).
happy(alice).
happy(bob).
happy(bill).

with_albert(alice).

% Rule
runs(albert) :-
	happy(albert).

dances(alice) :-
	happy(alice),
	with_albert(alice).

does_alice_dance :- dances(alice), 
	write('When Alice is happy and she is with ALbert, she dances.').

% Can merge the upper 2 rules as:
dances(alice) :-
	happy(alice),
	with_albert(alice),
	write('When Alice is happy and she is with ALbert, she dances.').

% Will return error, since AND reqquires both facts to be true - but near_water predicate is not defined
/**********************
swims(bill) :-
	happy(bill),
	near_water(bill).
***********************/

% But if we split the and condition into 2 different rules, either of the rules being true, gices ans as true.
% Therefore, it is ok if one of the rule has an undefined predicate
swims(bill) :-
	happy(bill).
swims(bill) :-
	near_water(bill).