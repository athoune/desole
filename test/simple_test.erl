-module(simple_test).
-include_lib("eunit/include/eunit.hrl").

function_test() ->
    M = desole:functions([desole_math, desole_flow]),
    F = lists:reverse(lists:foldl(
        fun({Name, _Fun}, Acc) ->
            [Name | Acc]
        end, [], M)),
    ?assertEqual([add,remove,times,'div','if',ifelse,while,for], F).

%% add(2, 1)
add_test() ->
    {ok, _Context, A} = desole:run([], [desole_math], [{'fun', add, [{int, 2}, {int, 1}]}]),
    ?assertEqual({int, 3}, A).

%% remove(add(2, 1), 3)
compose_test() ->
    {ok, _Context, A} = desole:run([], [desole_math], [
        {'fun',  remove, [
            {'fun', add, [{int, 2}, {int, 1}]},
            {int, 3}]
        }]),
    ?assertEqual({int, 0}, A).

multiline_test() ->
    {ok, _Context, A} = desole:run([], [desole_math], [
            {'fun', add, [{int, 1}, {int, 1}]},
            {int, 42}
        ]),
    ?assertEqual({int, 42}, A).

stack_test() ->
    {ok, _Context, A} = desole:run([{a,{int, 42}}], [desole_math], [
        {var, a}
    ]),
    ?assertEqual({int, 42}, A).

set_test() ->
    {ok, _Context, A} = desole:run([], [desole_math, desole_stack], [
        {'fun', set, [{atom, a}, {int, 42}]},
        {var, a}
    ]),
    ?assertEqual({int, 42}, A),
    {ok, _Context2, B} = desole:run([], [desole_math, desole_stack], [
        {'fun', set, [{atom, a}, {int, 42}]},
        {'fun', set, [{atom, b}, {'fun', times, [{int, 2}, {'fun', get, [{atom, a}]}]}]},
        {var, b}
    ]),
    ?assertEqual({int, 84}, B).


del_test() ->
    {ok, _Context, A} = desole:run([{a, {int, 42}}], [desole_math, desole_stack], [
        {'fun', del, [{atom, b}]}, %% does nothing but shouldn't crash
        {'fun', del, [{atom, a}]},
        {var, a}
    ]),
    ?assertEqual(nil, A).

