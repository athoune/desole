-module(desole_compare).

-export([gt/2, lt/2, eq/2]).

-export([export/0]).
-behaviour(desole_lib).

export() -> [
        {gt, fun gt/2},
        {lt, fun lt/2},
        {eq, fun eq/2}
    ].

gt(Context, [{int, A}, {int, B}]) ->
    {ok, Context, A > B}.

lt(Context, [{int, A}, {int, B}]) ->
    {ok, Context, A < B}.

eq(Context, [{int, A}, {int, B}]) ->
    {ok, Context, A == B}.
