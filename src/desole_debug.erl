-module(desole_debug).

-export([dump/2]).

-export([export/0]).
-behaviour(desole_lib).

export() -> [
        {dump, fun dump/2}
    ].

dump(Context, Args) ->
    io:format("Desole:dump ~p~n", [Args]),
    {ok, Context, nil}.
