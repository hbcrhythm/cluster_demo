-module(connector_remote).

-export([session_get/1, notify/3]).

session_get(_Msg) ->
	{ok, SrvId} = application:get_env(cluster, srv_id),
	SessionId = random:uniform(100000),
	lager:info("##connector## :: session get Id: ~w",[SessionId]),
	SessionList = application:get_env(demo, session_list),
	SessionList2 = case SessionList of
		undefined ->
			[SessionId];
		{ok, List} ->
			[SessionId | List]
	end,
	application:set_env(demo, session_list, SessionList2),
	{SrvId, SessionId}.

notify(GateSrvId, SessionId, Msg) ->
	lager:info("##connector## :: notify: ~w",[Msg]),
	SessionList = application:get_env(demo, session_list),
	case SessionList of
		undefined ->
			ignore;
		{ok, List} ->
			case lists:member(SessionId, List) of
				true ->
					cluster_stdlib:cast(GateSrvId, gate_remote, notify, [Msg]),
					ok;
				false ->
					ignore
			end
	end.