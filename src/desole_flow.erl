-module(desole_flow).

-export([if_/2, ifelse/2, while/2, for/2]).

-export([export/0]).
-behaviour(desole_lib).

export() -> [
        {'if', fun if_/2},
            {ifelse, fun ifelse/2},
            {while, fun while/2},
            {for, fun for/2}
    ].

if_(Context, _Args) -> {ok, Context, nil}.
ifelse(Context, _Args) -> {ok, Context, nil}.
while(Context, _Args) -> {ok, Context, nil}.
for(Context, _Args) -> {ok, Context, nil}.
