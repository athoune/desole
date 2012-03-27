-module(desole_boolean).

-export(['or'/2, 'and'/2, 'not'/2]).
-export([export/0]).
-behaviour(desole_lib).

export() -> [
        {'or', fun 'or'/2},
        {'and', fun 'and'/2},
        {'not', fun 'not'/2}
    ].

'or'(Context, [{boolean, A}, {boolean, B}]) ->
    {ok, Context, A or B}.

'and'(Context, [{boolean, A}, {boolean, B}]) ->
    {ok, Context, A and B}.

'not'(Context, [{boolean, A}]) ->
    {ok, Context, not(A)}.
