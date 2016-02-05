
-record(oauth2_clients, {
client_id,
client_secret,
redirect_uri,
grant_types,
scope,
user_id}).

-record(oauth2_access_tokens, {
access_token,
client_id,
user_id,
expires,
scope}).

-record(oauth2_authorization_codes, {
authorization_code,
client_id,
user_id,
redirect_uri,
expires,
scope}).

-record(oauth2_refresh_tokens, {
refresh_token,
client_id,
user_id,
expires,
scope}).

-record(oauth2_users, {
username,
password,
first_name,
last_name}).

-record(oauth2_scopes, {
scope,
is_default}).

-record (oauth2_jwt, {
client_id,
subject}).
