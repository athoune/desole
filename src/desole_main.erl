-module(desole_main).

-export([add/2, remove/2]).

add(Context, [{int, A}, {int, B}]) ->
    {ok, Context, {int, A + B} }.

remove(Context, [{int, A}, {int, B}]) ->
    {ok, Context, {int, A - B} }.
