% Trace the map
trace(Map, [], [X, Y]) :- check_loc(Map, X, Y, e).

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

% Display map as series of points
disp_map(Map) :-
    check_loc(Map, X, Y, Ele),
    write("("), write(X), write(","), write(Y),
    write(") = "), write(Ele), nl, false.

% Right
move([X, Y], [Nx, Y], right) :- Nx is X + 1.
% Left
move([X, Y], [Nx, Y], left) :- Nx is X - 1.
% Down
move([X, Y], [X, Ny], down) :- Ny is Y + 1.
% Up
move([X, Y], [X, Ny], up) :- Ny is Y - 1.

% Check if given element is a member of the list
memberCheck([_|T], H) :- memberCheck(T, H).
memberCheck([H|_], H).

% Recursively iterate through the map, finding the correct path
iter_map(_, [EndX, EndY], [EndX, EndY], _, _).

iter_map(Map, [X, Y], [EndX, EndY], Visited, Actions) :-
    move([X, Y], [Nx, Ny], Dir),
    (check_loc(Map, Nx, Ny, f); check_loc(Map, Nx, Ny, e)),
    memberCheck(Visited, [Nx, Ny]),
    write("Iterating"), nl,
    iter_map(Map, [Nx, Ny], [EndX, EndY], [Visited|[Nx, Ny]], [Actions|Dir]).

% Main function to call
%find_exit([], _) :- false.
find_exit(Map, Actions) :-
    check_loc(Map, X, Y, s),
    check_loc(Map, EndX, EndY, e),
    write("Initial position at: ("), write(X), write(","), write(Y), write(")"), nl,
    write("Final position at: ("), write(EndX), write(","), write(EndY), write(")"), nl,
    iter_map(Map, [X, Y], [EndX, EndY], [], Actions).
