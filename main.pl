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
			inventory(I),
			C = I,
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
	
	
isWalkable(X, Y, S):-
	\+(posObst(X, Y)),
	\+(posWW(X, Y, S)),
	maxX(MX),
	maxY(MY),
	X =< MX,
	Y =< MY,
	X >= 0,
	Y >= 0.

allWWkilled(S) :-
    killedWW(1, 0, S),
    killedWW(2, 0, S),
    killedWW(0, 2, S).





%haveDs(C, S) :-
%	posJon(_, _, C, S),
%	C > 0.
	
%killedWW(X, Y, s0).
%killedWW(X, Y, result(A, S)):-
%	killedWW(X, Y, S),
%	\+posWW(X, Y, S),
%	(
%	A = right;
%	A = left;
%	A = killWW;
%	A = up;
%	A = down
%	).
  
%Successor state of dsJon
% dsJon(X, result(A, S)) :-
% 	(	
% 		(
% 				A = killWW, Y is X+1, dsJon(Y,S)
% 		);
% 		(
% 			maximum_dragon_glasses(Z),
% 			dsJon(X+Z,S),
% 			(
% 			(A = right, isWalkable(X+1, Y, S), posDS(X+1, Y));
% 			(A = left, isWalkable(X-1, Y, S), posDS(X-1, Y));
% 			(A = up, isWalkable(X, Y-1, S), posDS(X, Y-1));
% 			(A = down, isWalkable(X, Y+1, S), posDS(X, Y+1))
% 			)
			
% 		)
% 	);
%     (
% 		dsJon(X,S),
% 		(
% 		(A = right, isWalkable(X+1, Y, S), \+posDS(X+1, Y));
% 		(A = left, isWalkable(X-1, Y, S), \+posDS(X-1, Y));
% 		(A = up, isWalkable(X, Y-1, S), \+posDS(X, Y-1));
% 		(A = down, isWalkable(X, Y+1, S), \+posDS(X, Y+1))
% 		)	
% 	).
