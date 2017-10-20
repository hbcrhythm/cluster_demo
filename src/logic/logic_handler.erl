-module(logic_handler).

-export([handle/4]).

handle(GateSrvId, ConnectorSrvId, SessionId, Msg) ->
	lager:info("##logic## :: handle msg: ~w ",[Msg]),
	Tag = random:uniform(100000),
	cluster_stdlib:cast(ConnectorSrvId, connector_remote, notify, [GateSrvId, SessionId, Tag]),
	lager:info("##logic## :: handle msg finished"),
	{SessionId, Tag}.