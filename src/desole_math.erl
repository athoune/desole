-module(desole_math).

-export([add/2, remove/2]).

-export([export/0]).
-behaviour(desole_lib).

export() -> [
        {add, fun add/2},
        {remove, fun remove/2},
        {times, fun times/2},
        {'div', fun div_/2}
    ].

add(Context, [{int, A}, {int, B}]) ->
    {ok, Context, {int, A + B} }.

remove(Context, [{int, A}, {int, B}]) ->
    {ok, Context, {int, A - B} }.

times(Context, [{int, A}, {int, B}]) ->
    {ok, Context, {int, A * B} }.

div_(Context, [{int, A}, {int, B}]) ->
    {ok, Context, {int, A / B} }.
