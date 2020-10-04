% Given Ques:

myClause(1, or(a_1, a_2)).

myClause(2, or(or(neg(a_2), b_2), b_3)).

myClause(3, or(neg(b_2), b_3)).

myClause(4, neg(b_3)).

myQuery(5, a_1).

/*************************************************

%%%%%%%%%%%%%%%%%%%%%%%%%% QUIZ Ques %%%%%%%%%%%%%%%%%%%%%%

% Ques 1: - DONE

myClause(1, or(p, q)).

myClause(2, or(neg(p), r)).

myClause(3, or(neg(q), r)).

myClause(4, or(p, s)).

myQuery(5, or(r, s)).

% Ques 2:

myClause(1, or(neg(p), r)).

myClause(2, or(p, r)).

myQuery(3, r).

% Ques 3: - DONE

myClause(1, or(neg(p), r)).

myClause(2, or(neg(r), s)).

myClause(3, or(neg(s), t)).

myClause(4, or(neg(t), v)).

myClause(5, or(neg(v), w)).

myClause(6, or(neg(w), u)).

myClause(7, p).

myQuery(8, u).


% Ques 4: - DONE

myClause(1, p).

myClause(2, or(neg(p), r)).

myClause(3, or(neg(r), s)).

myClause(4, or(or(neg(s), neg(t)),x)).

myClause(5, or(t, v)).

myClause(6, or(neg(v), w)).

myClause(7, or(neg(w), u)).

myClause(8, neg(u)).

myQuery(9, x).



myClause(1, or(neg(p), r)).

myClause(2, or(neg(r), s)).

myClause(3, or(neg(s), t)).

myClause(4, or(neg(t), v)).

myClause(5, or(neg(v), w)).

myClause(6, or(neg(w), u)).

myQuery(7, p).
************************************************/