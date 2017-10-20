-module(gate_remote).

-export([notify/1]).

notify(_Msg) ->
	lager:info("##gate## :: notify").