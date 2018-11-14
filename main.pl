maxX(3).
maxY(3).
inventory(10).

%Obstacles
posObst(1, 1).

%WhiteWalkers
posWW(1, 0, s0).
posWW(3, 0, s0).

posDS(3, 1).


allWWkilled(S) :-
    killedWW(1, 0, S),
    killedWW(3, 0, S).

isWalkable(X, Y, S):-
	\+(posObst(X, Y)),
	\+(posWW(X, Y, S)),
	maxX(MaxX),
	maxY(MaxY),
	X =< MaxX,
	Y =< MaxY,
	X >= 0,
	Y >= 0.

posJon(3, 3	, 0, s0).
%Successor state of posJon
posJon(X, Y, C, result(A, S)):-
    (
		(	
			isWalkable(X, Y, S),
			\+posDS(X, Y),
			(
				(A = right, X1 is X-1, posJon(X1, Y, C, S));
				(A = left,  X2 is X+1, posJon(X2, Y, C, S));
				(A = up,  Y1 is Y+1, posJon(X, Y1, C, S));
				(A = down,  Y2 is Y-1, posJon(X, Y2, C, S))
			)
		);
		(
			isWalkable(X, Y, S),
			posDS(X, Y),
			inventory(D),
			C = D,
			(
				(A = right, X1 is X-1, posJon(X1, Y, 0, S));
				(A = left,  X2 is X+1, posJon(X2, Y, 0, S));
				(A = up,  Y1 is Y+1, posJon(X, Y1, 0, S));
				(A = down,  Y2 is Y-1, posJon(X, Y2, 0, S))
			)
		)
    );
    (
        (
			posJon(X, Y, C, S),
			(
				(A = right, X2 is X+1, \+isWalkable(X2, Y, S));
				(A = left, X1 is X-1,  \+isWalkable(X1, Y, S));
				(A = up, Y2 is Y-1,  \+isWalkable(X, Y2, S));
				(A = down, Y1 is Y+1,  \+isWalkable(X, Y1, S))
			)
		);
		(
			posJon(X, Y, C1, S),
			C1 > 0,
			C is C1-1,
			A = killWW,	
			(
				(X2 is X+1, posWW(X2, Y, S));
				(X1 is X-1, posWW(X1, Y, S));
				(Y2 is Y-1, posWW(X, Y2, S));
				(Y1 is Y+1, posWW(X, Y1, S))
			)
		)
    ).

posWW(X, Y, result(A, S)):-
		posWW(X, Y, S),
		\+killedWW(X, Y, result(A, S)).
		

%Successor state of killedWW
killedWW(X, Y, result(A, S)):-	
		(
			A = killWW,
			(
				(X1 is X-1, posJon(X1, Y, C, S), C > 0);
				(X2 is X+1, posJon(X2, Y, C, S), C > 0);
				(Y1 is Y-1, posJon(X, Y1, C, S), C > 0);
				(Y2 is Y+1, posJon(X, Y2, C, S), C > 0)
			)
		);
		(
		(killedWW(X, Y, S))
		).		

iterativekill(S, X) :-
	call_with_depth_limit(allWWkilled(S), X, _);
	(
	X1 is X + 1,
	iterativekill(S, X1)
	).