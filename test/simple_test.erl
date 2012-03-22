-module(simple_test).
-include_lib("eunit/include/eunit.hrl").

add_test() ->
    A = desole:run([], [{add, fun desole_main:add/2}], [[add, {int, 2}, {int, 1}]]),
    io:format("~p~n", [A]).
