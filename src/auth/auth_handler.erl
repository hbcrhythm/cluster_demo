-module(auth_handler).

-export([auth/1]).

auth(_Msg) ->
	lager:info("##auth## :: auth msg"),
	Reply = ok,
	{Reply}.