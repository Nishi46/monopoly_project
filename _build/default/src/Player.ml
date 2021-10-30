type player_id = int

type amount = int

type location = string

type player = {
  id : player_id;
  current_amount : amount;
  properties : string list;
  current_location : location;
}

let get_current_location player = player.current_location

let get_player_id player = player.id

let get_all_properties player = player.properties

let get_current_amt player = player.current_amount
