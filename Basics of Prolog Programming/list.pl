/***************************
| - One of more elements in a list after it
  - Can eliminate one list after it
  - Eg. [a,b,|X] = [a,b,|[c,d]] = [a,b,c,d]

Egs.
1. [a,b,c,d] = [X, Y|Z].
	X = a, Y = b, Z = [c,d]

2. [a,b,c,d] = [a,b,|[[c,d]]]
	Not equal (| - Can remove only one list)

3. [mth110 | [mth210 | [cps305 | [cps721 | CPS822]]]] = [P, R, Q | AI].
	[mth210, mth210, cps305, cps721 | CPS822]
	CPS822 - First letter uppercase - Its a variable not an atom - Very important
		   - Bar needs to have a list after it - If its a variable, it may have some value which is a list
		   - Never replace a variable after a bar - Leave it as it is with the bar
	P = mth110
	Q = mth210
	R = cps305
	AI = List of whatever is left = [cps721 | CPS822].

4. [List | [List, a, b, c]] = [[], Z | U].
	[List, List, a, b, c]
	List - First Letter uppercase - Variable - Can take any value
	List = [] (Empty list)
	Z = List = []
	U = [a, b, c]

5. [U, [W | U], a, b] = [Z | [[a | [b]] | W]].
	[U, [W | U], a, b] = [Z, [a, b] | W]
	U = Z
	W = a
	U = Z = [b]
	W = a
	Therefore, not equal

6. [k, p | U] = [k, W, m, n, [W | [c]]].
	[k, p, | U] = [k, W, m, n, [W, c]]
	k = k
	W = p
	U = List of whatever is remaining = [m, n, [W, c]] = [m, n, [p, c]]

7. [k, [Q | [l, m]], tree | [book | Z]] = [P, U | [R, Q, n]].
	[k, [Q, l, m], tree, book | Z] = [P, U, R, Q, n]
	P = k
	U = [Q, l, m] = [book, l, m]
	R = tree
	Q = book
	Z = [n]
****************************/