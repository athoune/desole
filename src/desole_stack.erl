-module(desole_stack).
-behaviour(desole_lib).

-export([set/2, del/2]).

-export([export/0]).

-include("desole.hrl").

export() -> [
        {set, fun set/2},
        {del, fun del/2},
        {get, fun get/2}
    ].

set(Context, [{atom, Key}, Value]) ->
    {#context{stack = Stack} = Context2, Value2} = desole:eval(Context, Value),
    NewStack = [{Key, Value2} | proplists:delete(Key, Stack)],
    {ok, Context2#context{stack = NewStack}, Value}.

get(#context{stack = Stack} = Context, [{atom, Key}]) ->
    Value = proplists:get_value(Key, Stack, nil),
    {ok, Context, Value}.

del(#context{stack = Stack} = Context, [{atom, Key}]) ->
    NewStack = proplists:delete(Key, Stack),
    {ok, Context#context{stack = NewStack}, nil}.
