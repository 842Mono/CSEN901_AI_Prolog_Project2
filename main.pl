posObst(1, 1).
posDS(0, 2).

posWW(0, 0, s0).
posWW(0, 1, s0).

maximum_dragon_glasses(3).
%number of dragon glass
dsJon(0 ,s0).

maxX(2).
maxY(2).

isWalkable(X, Y, S):-
    \+posObst(X, Y),
    \+posWW(X, Y, S),
    maxX(MX), X =< MX,
    maxY(MY),Y =< MY,
    X >= 0, Y >= 0.
	
haveDs(S) :- 
	posJon(X, Y, C, S),
	C > 0.

posJon(2, 2, 0, s0).
%Successor state of posJon
posJon(X, Y, C, result(A, S)):-
    (
		(	
			isWalkable(X, Y, S),
			\+posDS(X, Y),
			(
				(A = right, posJon(X-1, Y, C, S));
				(A = left, posJon(X+1, Y, C, S));
				(A = up, posJon(X, Y+1, C, S));
				(A = down, posJon(X, Y-1, C, S))
			)
		);
		(
			isWalkable(X, Y, S),
			maximum_dragon_glasses(Z),
			C1 is C-Z,
			posDS(X, Y),
			(
				(A = right, posJon(X-1, Y, C1, S));
				(A = left, posJon(X+1, Y, C1, S));
				(A = up, posJon(X, Y+1, C1, S));
				(A = down, posJon(X, Y-1, C1, S))
			)
		)
    );
    (
        (
			posJon(X, Y, C, S),
			(
				(A = right, posObst(X+1, Y));
				(A = left, posObst(X-1, Y));
				(A = up, posObst(X, Y-1));
				(A = down, posObst(X, Y+1))
			)
		);
		(
			C1 is C+1,
			posJon(X, Y, C1, S),
			A = killWW,
			haveDs(S),
			(
				posWW(X+1, Y, S);
				posWW(X-1, Y, S);
				posWW(X, Y-1, S);
				posWW(X, Y+1, S)
			)
		)
    ).

	
%Successor state of posWW
posWW(X, Y, result(A, S)) :-
	posWW(X, Y, S),
	(
		(A \= killWW);
		(
			A = killWW,
			\+posJon(X-1, Y, C, S),
			\+posJon(X+1, Y, C, S),
			\+posJon(X, Y-1, C, S),
			\+posJon(X, Y+1, C, S)
		);
		(
			A = killWW,
			(
				posJon(X-1, Y, C, S);
				posJon(X+1, Y, C, S);
				posJon(X, Y-1, C, S);
				posJon(X, Y+1, C, S)
			),
			\+haveDs(S)
		)
	).
	
	
killedWW(X, Y, S) :-
	\+posWW(X, Y, S).

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
goalTest(X, Y, S):-
	open('file.txt',write, Stream),
	forall(posWW(X, Y, S), write(Stream,posWW(X, Y, S))),
	close(Stream).
	
readfacts:-
    open('file.txt',read,In),
    repeat,
    read_line_to_codes(In,X),writef(" "),
	writef(""),nl,
    writef(X),nl,
    X=end_of_file,!,
    nl,
    close(In).
	
   
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