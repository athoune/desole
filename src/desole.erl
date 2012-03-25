-module(desole).

-export([run/3, auto_type/1]).


-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-export([functions/1]).
-endif.

run(Context, Libs, Actions) ->
    run(Context, Libs, Actions, nil).

run(Context, Libs, Actions, Result) ->
    run_(Context, functions(Libs), Actions, Result).

run_(Context, Methods, [{Action, Args}|Tail], _Result) ->
    F = proplists:get_value(Action, Methods),
    {ok, NewContext, NewResult} = F(Context, Args),
    run_(NewContext, Methods, Tail, NewResult);
run_(Context, _Methods, [], Result) ->
    {ok, Context, Result}.

functions(Libs) ->
    lists:flatten(lists:foldl(fun(T, Acc) ->
                [Acc | T:export()]
        end, [], Libs)).

auto_type(A) when is_integer(A) -> {int, A};
auto_type(A) -> A.
