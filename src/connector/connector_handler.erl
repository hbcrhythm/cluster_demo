-module(connector_handler).

-export([transpond/3]).

transpond(GateSrvId, SessionId, Msg) ->
	{ok, SrvId} = application:get_env(cluster, srv_id),
	{ok, SessionList} = application:get_env(demo, session_list),
	case lists:member(SessionId, SessionList) of
		true ->
			random:seed(os:timestamp()),
			cluster_stdlib:cast(logic, logic_handler, handle, [GateSrvId, SrvId, SessionId, Msg]),
			lager:info("##connector## :: transpond finished");
		false ->
			lager:info("##connector## :: transpond fail"),
			{error, not_exist_session_id, SessionId}
	end.