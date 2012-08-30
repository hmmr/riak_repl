%% Riak Core Connection Manager
%% Copyright (c) 2012 Basho Technologies, Inc.  All Rights Reserved.

%% handshake messages to safely initiate a connection. Let's not accept
%% a connection to a telnet session by accident!
-define(CTRL_HELLO, <<"riak-ctrl:hello">>).
-define(CTRL_ACK, <<"riak-ctrl:ack">>).

-define(CONNECTION_SETUP_TIMEOUT, 60000).

-type(ip_addr_str() :: string()).
-type(ip_portnum() :: non_neg_integer()).
-type(ip_addr() :: {ip_addr_str(), ip_portnum()}).
-type(tcp_options() :: [any()]).

-type(proto_id() :: atom()).
-type(rev() :: non_neg_integer()). %% major or minor revision number
-type(proto() :: {proto_id(), {rev(), rev()}}). %% e.g. {realtime_repl, 1, 0}
-type(protoprefs() :: {proto_id(), [{rev(), rev()}]}).

-type(cluster_finder_fun() :: fun(() -> {ok,ip_addr()} | {error, term()})).

%% Function = fun(Socket, Transport, Protocol, Args) -> ok
%% Protocol :: proto()
-type(service_started_callback() :: fun((inet:socket(), module(), proto(), [any()]) -> no_return())).

%% Host protocol spec
-type(hostspec() :: {protoprefs(), {tcp_options(), module(), service_started_callback(), [any()]}}).

%% Client protocol spec
-type(clientspec() :: {protoprefs(), {tcp_options(), module(),[any()]}}).
