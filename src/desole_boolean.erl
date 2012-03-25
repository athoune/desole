-module(desole_boolean).

-export([or_/2, and_/2, not_/2]).
-export([export/0]).
-behaviour(desole_lib).

export() -> [
        {'or', fun or_/2},
        {'and', fun and_/2},
        {'not', fun not_/2}
    ].

or_(Context, [{boolean, A}, {boolean, B}]) ->
    {ok, Context, A or B}.

and_(Context, [{boolean, A}, {boolean, B}]) ->
    {ok, Context, A and B}.

not_(Context, [{boolean, A}]) ->
    {ok, Context, not(A)}.
