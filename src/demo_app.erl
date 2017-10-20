%%%-------------------------------------------------------------------
%% @doc demo public API
%% @end
%%%-------------------------------------------------------------------

-module(demo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    {ok, Pid} = demo_sup:start_link(),
    {ok, NodeType} = application:get_env(cluster, node_type),
    ServerList = case NodeType of
    	auth ->
    		[{auth_mod, {auth_mod, start_link, []}, transient, 10000, worker, [auth_mod]}];
    	gate ->
    		[{gate_mod, {gate_mod, start_link, []}, transient, 10000, worker, [gate_mod]}];
    	connector ->
    		[{connector_mod, {connector_mod, start_link, []}, transient, 10000, worker, [connector_mod]}];
    	logic ->
    		[{logic_mod, {logic_mod, start_link, []}, transient, 10000, worker, [logic_mod]}]
    end,
    start_child(ServerList),
    {ok, Pid}.
%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

start_child([]) -> ok;
start_child([ChildSpec | T]) ->
	supervisor:start_child(demo_sup, ChildSpec),
	start_child(T).