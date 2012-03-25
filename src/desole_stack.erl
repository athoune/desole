-module(desole_stack).
-behaviour(desole_lib).

-export([set/2, del/2]).

-export([export/0]).

-include("desole.hrl").

export() -> [
        {set, fun set/2},
        {del, fun del/2}
    ].

set(#context{stack = Stack} = Context, [{atom, Key}, Value]) ->
    NewStack = [{Key, Value} | proplists:delete(Key, Stack)],
    {ok, Context#context{stack = NewStack}, Value}.
del(#context{stack = Stack} = Context, [{atom, Key}]) ->
    NewStack = proplists:delete(Key, Stack),
    {ok, Context#context{stack = NewStack}, nil}.
