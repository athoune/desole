-module(simple_test).
-include_lib("eunit/include/eunit.hrl").

function_test() ->
    M = desole:functions([desole_main, desole_flow]),
    F = lists:reverse(lists:foldl(
        fun({Name, _Fun}, Acc) ->
            [Name | Acc]
        end, [], M)),
    ?assertEqual([add,remove,'if',ifelse,while,for], F).

add_test() ->
    A = desole:run([], [desole_main], [{add, [{int, 2}, {int, 1}]}]),
    ?assertEqual({ok, [], {int, 3}}, A).
