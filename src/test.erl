%% @doc test util
-module(test).

-export([login/0, send/0]).

%% @doc at gate server
login() ->
	Id = 1,
	Token = "love",
	Msg = {Id, Token},
	gate_handler:enter(Msg).


send() ->
	Token = "hello world",
	gate_handler:send_proto(Token).