
isWalkable(X, Y, S):-
    not(posObst(X, Y)),
    not(posWW(X, Y, S)),
    maxX(MX), X =< MX,
    maxY(MY),Y =< MY,
    X >= 0, Y >= 0.
	
haveDs(X, Y, C, S) :-
	posJon(X, Y, C, S),
	C > 0.
	

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
			C1 is C-3,
			posDS(X, Y),
			(
				(A = right, X1 is X-1, posJon(X1, Y, C1, S));
				(A = left,  X2 is X+1, posJon(X2, Y, C1, S));
				(A = up,  Y1 is Y+1, posJon(X, Y1, C1, S));
				(A = down,  Y2 is Y-1, posJon(X, Y2, C1, S))
			)
		)
    );
    (
        (
			posJon(X, Y, C, S),
			(
				(A = right, X2 is X+1, posObst(X2, Y));
				(A = left, X1 is X-1, posObst(X1, Y));
				(A = up, Y2 is Y-1, posObst(X, Y2));
				(A = down, Y1 is Y+1, posObst(X, Y1))
			)
		);
		(
			
			C1 is C+1,
			haveDs(X, Y, C1, S),
			A = killWW,	
			(
				X2 is X+1, posWW(X2, Y, S);
				X1 is X-1, posWW(X1, Y, S);
				Y2 is Y-1, posWW(X, Y2, S);
				Y1 is Y+1, posWW(X, Y1, S)
			),
			
			posJon(X, Y, C1, S)
		)
    ).

	
%Successor state of posWW
posWW(X, Y, result(A, S)):-
	posWW(X, Y, S),
	(
		
		(
			A \= killWW,
			(
				(X1 is X-1, \+posJon(X1, Y, C, S));
				(X2 is X+1, \+posJon(X2, Y, C, S));
				(Y1 is Y-1, \+posJon(X, Y1, C, S));
				(Y2 is Y+1, \+posJon(X, Y2, C, S))
			);
			(
				(X1 is X-1, posJon(X1, Y, C, S));
				(X2 is X+1, posJon(X2, Y, C, S));
				(Y1 is Y-1, posJon(X, Y1, C, S));
				(Y2 is Y+1, posJon(X, Y2, C, S))
			)
		);
		
		(
			A = killWW,
			(
				(X1 is X-1, \+posJon(X1, Y, C, S)),
				(X2 is X+1, \+posJon(X2, Y, C, S)),
				(Y1 is Y-1, \+posJon(X, Y1, C, S)),
				(Y2 is Y+1, \+posJon(X, Y2, C, S))
			)
		);
		(
			A = killWW,
			(
				(X1 is X-1, posJon(X1, Y, C, S), \+haveDs(X1, Y, C, S));
				(X2 is X+1, posJon(X2, Y, C, S), \+haveDs(X2, Y, C, S));
				(Y1 is Y-1, posJon(X, Y1, C, S), \+haveDs(X, Y1, C, S));
				(Y2 is Y+1, posJon(X, Y2, C, S), \+haveDs(X, Y2, C, S))
			)
		)
	).
	
	

killedWW2(X, Y, S) :-
not(posWW(X, Y, S)).		



posObst(1, 1).
posObst(0, 1).
posDS(2, 1).

posJon(2, 2, 0, s0).

maximum_dragon_glasses(3).

maxX(2).
maxY(2).

posWW(0, 0, s0).





	
	




	
	
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