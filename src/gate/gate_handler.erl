-module(gate_handler).

-export([enter/1, send_proto/1]).

enter(Msg) ->
	lager:info("##gate## :: enter gate"),
	Result = cluster_stdlib:call(auth, auth_handler, auth, [Msg]),
	lager:info("##gate## :: result: ~w", [Result]),
	case Result of
		{ok} ->
			{SrvId, SessionId} = cluster_stdlib:call(connector, connector_remote, session_get, [Msg]),
			lager:info("##gate## :: SrvId: ~w, SessionId: ~w",[SrvId, SessionId]),
			put(session_id, SessionId),
			put(srv_id, SrvId),
			{SrvId, SessionId};
		_ ->
			ignore
	end.

send_proto(Msg) ->
	{ok, SrvId} = application:get_env(cluster, srv_id),
	lager:info("##gate## :: send proto"),
	cluster_stdlib:cast(get(srv_id), connector_handler, transpond, [SrvId, get(session_id), Msg]),
	lager:info("##gate## :: send proto ~w ~w finished ",[get(srv_id), Msg]).