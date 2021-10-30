open Property 
type player_id = int

type amount = int

type location = string

exception InvalidPlayerNumber

type player = {
  id : player_id;
  current_amount : amount;
  properties : string list;
  current_location : property_id;
}

let create_player_record_helper number = 
  {id= number; current_amount = 1500; properties = []; current_location = 1}
let create_player_record no_of_players = 
  match no_of_players with 
  | 0 -> raise InvalidPlayerNumber
  | _ -> create_player_record_helper no_of_players

let player_records players_list = 
  let 
let get_current_location player = player.current_location

let get_player_id player = player.id

let get_all_properties player = player.properties

let get_current_amt player = player.current_amount
