open Yojson.Basic.Util

type room_id = string

type exit_name = string

exception UnknownRoom of room_id

exception UnknownExit of exit_name