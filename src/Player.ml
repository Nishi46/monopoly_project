open Yojson.Basic.Util

type player_id = int

type amount = int

type player = {
  id : player_id;
  current_amount : int;
  properties : string list;


}