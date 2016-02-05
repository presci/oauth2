-module(oauth2_app).
-behaviour(application).

-include("oauth2_record.hrl").

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    ok = ensure_mnesia_create(),
    ok = ensure_mnesia_start(),
    ok = create_table(mnesia:create_table(oauth2_clients, [{disc_copies, [node()]},
				   {attributes, record_info(fields, oauth2_clients)}])),
    ok = create_table(mnesia:create_table(oauth2_access_tokens, [{disc_copies, [node()]},
				   {attributes, record_info(fields, oauth2_access_tokens)}])),
    ok = create_table(mnesia:create_table(oauth2_authorization_codes, [{disc_copies, [node()]},
				   {attributes, record_info(fields, oauth2_authorization_codes)}])),
    ok = create_table(mnesia:create_table(oauth2_refresh_tokens, [{disc_copies, [node()]},
				   {attributes, record_info(fields, oauth2_refresh_tokens)}])),
    ok = create_table(mnesia:create_table(oauth2_users, [{disc_copies, [node()]},
				   {attributes, record_info(fields, oauth2_users)}])),
    ok = create_table(mnesia:create_table(oauth2_scopes, [{disc_copies, [node()]},
				   {attributes, record_info(fields, oauth2_scopes)}])),
    ok = create_table(mnesia:create_table(oauth2_jwt, [{disc_copies, [node()]},
				   {attributes, record_info(fields, oauth2_jwt)}])),

    oauth2_sup:start_link().

stop(_State) ->
	ok.



%% methods
ensure_mnesia_start() ->
    case mnesia:start() of
	ok ->
	    ok;
	{error, Reason} ->
	    io:format("Failed Reason : ~p~n", [Reason]),
	    error
    end.

ensure_mnesia_create () ->
    mnesia:stop(),
    case mnesia:create_schema([node()]) of
	ok ->
	    ok;
	{error, {Node, {already_exists, Node}}} -> 
	    ok;
	Error  ->
	    Error
    end.


create_table ({atomic, ok}) ->
    ok;
create_table ({aborted, {already_exists, Tablename}}) ->
    io:format("already exist ~p~n" , [Tablename]),
    ok;
create_table (A) ->
    A.
