%% @doc test util
-module(test).

-export([login/0, send/0, event/0, event_srvup_callback/1,event_srvdown_callback/1]).

%% @doc at gate server
login() ->
	Id = 1,
	Token = "love",
	Msg = {Id, Token},
	gate_handler:enter(Msg).


send() ->
	Token = "hello world",
	gate_handler:send_proto(Token).


%% @doc test event callback
event() ->
	cluster_stdlib:add_srvup_event({test, event_srvup_callback, []}),
	cluster_stdlib:add_srvdown_event({test, event_srvdown_callback, []}).

event_srvup_callback(Srv) ->
	lager:info("event_srvup_callback ~w",[Srv]).
event_srvdown_callback(Srv) ->
	lager:info("event_srvdown_callback ~w",[Srv]).