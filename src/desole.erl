-module(desole).

-export([run/3, auto_type/1, eval/2, evals/3]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-export([functions/1]).
-endif.

-include("desole.hrl").

run(Stack, Libs, Actions) ->
    run(Stack, Libs, Actions, nil).

run(Stack, Libs, Actions, Result) ->
    one_line(#context{stack = Stack, methods=functions(Libs)}, Actions, Result).

one_line(Context, [Head|Tail], _Result) ->
    {NewContext, NewResult} = eval(Context, Head),
    one_line(NewContext, Tail, NewResult);
one_line(Context, [], Result) ->
    {ok, Context, Result}.

eval(#context{methods=Methods} = Context, {'fun', Action, Args}) ->
    {NewContext, ArgsValue} = evals(Context, Args, []),
    F = proplists:get_value(Action, Methods),
    {ok, NewContext2, NewResult} = F(NewContext, ArgsValue),
    {NewContext2, NewResult};
eval(#context{stack=Stack} = Context, {var, Key}) ->
    {Context, proplists:get_value(Key, Stack, nil)};
eval(Context, Value) ->
    {Context, Value}.

evals(Context, [Var|Vars], Acc) ->
    {NewContext, Value} = eval(Context, Var),
    evals(NewContext, Vars, [ Value | Acc]);
evals(Context, [], Acc) ->
    {Context, lists:reverse(Acc)}.

functions(Libs) ->
    %% Accept Fun or atom
    lists:flatten(lists:foldl(fun(T, Acc) ->
                [Acc | T:export()]
        end, [], Libs)).

auto_type(A) when is_integer(A) -> {int, A};
auto_type(A) -> A.
