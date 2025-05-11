trace(Map, [], [X, Y]) :- check_loc(Map, X, Y, "e").

trace(Map, [up|InsT], [X, Y]) :-
    check_loc(Map, X, Y-1, f),
    trace(Map, [InsT], [X, Y-1]).

trace(Map, [down|InsT], [X, Y]) :-
    check_loc(Map, X, Y+1, f),
    trace(Map, [InsT], [X, Y+1]).

trace(Map, [left|InsT], [X, Y]) :-
    check_loc(Map, X-1, Y, f),
    trace(Map, [InsT], [X-1, Y]).

trace(Map, [right|InsT], [X, Y]) :-
    check_loc(Map, X+1, Y, f),
    trace(Map, [InsT], [X+1, Y]).

% Get Specified index
% Also iterates to find stuff. Will be useful to find Beginning and End
check_loc(Map, X, Y, Ele) :-
    nth0(Y, Map, Row),
    nth0(X, Row, Ele).

disp_map(Map) :-
    check_loc(Map, X, Y, Ele),
    write("("), write(X), write(","), write(Y),
    write(") = "), write(Ele), nl, false.

find_exit([], _) :- false.
%find_exit(Map, Actions).


