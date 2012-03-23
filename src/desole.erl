-module(desole).

-export([run/3, auto_type/1]).

-include_lib("eunit/include/eunit.hrl").

run(Context, Methods, Actions) ->
    run(Context, Methods, Actions, nil).

run(Context, Methods, [{Action, Args}|Tail], _Result) ->
    F = proplists:get_value(Action, Methods),
    {ok, NewContext, NewResult} = F(Context, Args),
    run(NewContext, Methods, Tail, NewResult);
run(Context, _Methods, [], Result) ->
    {ok, Context, Result}.


auto_type(A) when is_integer(A) -> {int, A};
auto_type(A) -> A.
