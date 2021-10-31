type player_id = int

type amount = int


exception InvalidPlayerNumber

type player = {
  id : player_id;
  current_amount : amount;
  properties : string list;
  current_location : int;
}

let create_player_record_helper number = 
  {id= number; current_amount = 1500; properties = []; current_location = 1}
let create_player_record no_of_players acc = 
  match no_of_players with 
  | 0 -> raise InvalidPlayerNumber
  | _ -> (create_player_record_helper no_of_players) :: acc

let player_records_list number acc = 
  create_player_record number []
let get_current_location player = player.current_location

let get_player_id player = player.id

let get_all_properties player = player.properties

let get_current_amt player = player.current_amount
