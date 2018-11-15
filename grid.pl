maxX(2).
maxY(2).
inventory(6).

%Obstacles
posObst(2, 0).
posObst(1, 2).

%WhiteWalkers
posWW(0, 0, s0).
posWW(0, 1, s0).

posDS(1, 0).


allWWkilled(S) :-
    killedWW(0, 0, S),
    killedWW(0, 1, S).