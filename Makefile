PROJECT = oauth2
PROJECT_DESCRIPTION = OAUTH2.0 Server Erlang/Cowboy
PROJECT_VERSION = 0.0.1


DEPS = cowboy jiffy
dep_jiffy = git https://github.com/davisp/jiffy master
include erlang.mk
