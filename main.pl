posObst(1, 1).
posDS(0, 2).
maximum_dragon_glasses(2).
maxX(2).
maxY(2).

posWW(0, 0, s0).
posWW(0, 1, s0).

e(0, 2, s0).
e(1, 0, s0).
e(2, 1, s0).
e(1, 2, s0).




isWalkable(X, Y, S):-
    \+posObst(X, Y),
    \+posWW(X, Y, S),
    maxX(MX), X =< MX,
    maxY(MY),Y =< MY,
    X >= 0, Y >= 0.

%X coordinate
%Y coordinate
posJon(2, 2, s0).
posJon(X, Y, result(A, S)):-
    (
        isWalkable(X, Y, S),
        (
            (A = right, posJon(X-1, Y, S));
            (A = left, posJon(X+1, Y, S));
            (A = up, posJon(X, Y+1, S));
            (A = down, posJon(X, Y-1, S))
        )
    );
    (
        posJon(X, Y, S), \+isWalkable(X, Y, S),
        (
            (A = right);
            (A = left);
            (A = up);
            (A = down)
        )
    ).

%number of dragon glass
dsJon(0 ,s0).
dsJon(X, result(A, S)) :-
    A = kill. %dg fel state elle fatet 2a2all b wa7da








%up


%down


%left


%right


%kill





man(andrew).
man(mina).
test:-
    forall(man(X),X).
