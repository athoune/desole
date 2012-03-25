-module(desole_lib).

-export([behaviour_info/1]).

behaviour_info(callbacks) -> [{export, 0}];
behaviour_info(_) -> undefined.
