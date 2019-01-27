maxX(2).
maxY(2).
inventory(6).

%Obstacles
posObst(0, 0).
posObst(2, 0).

%WhiteWalkers
posWW(1, 0, s0).
posWW(0, 1, s0).

posDS(2, 1).

posJon(2, 2, 0, s0).


allWWkilled(S) :-
    killedWW(1, 0, S),
    killedWW(0, 1, S).
