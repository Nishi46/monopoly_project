open Yojson.Basic.Util

type player_id = int

type amount = int

type location = string

type player = {
  id : player_id;
  current_amount : amount;
  properties : string list;
  current_location : location;
}