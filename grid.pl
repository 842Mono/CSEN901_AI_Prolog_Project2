maxX(2).
maxY(2).
inventory(5).

%Obstacles
posObst(1, 0).

%WhiteWalkers
posWW(0, 0, s0).
posWW(1, 1, s0).

posDS(1, 2).

posJon(2, 2, 0, s0).


allWWkilled(S) :-
    killedWW(0, 0, S),
    killedWW(1, 1, S).
