-module(simple_test).
-include_lib("eunit/include/eunit.hrl").

function_test() ->
    M = desole:functions([desole_main, desole_flow]),
    F = lists:reverse(lists:foldl(
        fun({Name, _Fun}, Acc) ->
            [Name | Acc]
        end, [], M)),
    ?assertEqual([add,remove,'if',ifelse,while,for], F).

%% add(2, 1)
add_test() ->
    {ok, _Context, A} = desole:run([], [desole_main], [{'fun', add, [{int, 2}, {int, 1}]}]),
    ?assertEqual({int, 3}, A).

%% remove(add(2, 1), 3)
compose_test() ->
    {ok, _Context, A} = desole:run([], [desole_main], [
        {'fun',  remove, [
            {'fun', add, [{int, 2}, {int, 1}]},
            {int, 3}]
        }]),
    ?debugFmt("~p~n", [A]),
    ?assertEqual({int, 0}, A).
