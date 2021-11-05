type player_id = int

type amount = int

exception InvalidPlayerNumber

type player = {
  id : player_id;
  current_amount : amount;
  properties : string list;
  current_location : int;
}

(* Initialize Player Function Begin *)

(* [create_player_record_helper number] creates a player type with game starting
    attributes and id = [number]. *)
let create_player_record_helper number = 
  {id = number; current_amount = 1500; properties = []; current_location = 1}

(* [create_player_record no_of_players acc] is a helper function to 
   [player_records_list number] *)
let rec create_player_record no_of_players acc = 
match no_of_players with 
| 0 -> acc
| 1 -> create_player_record_helper 1 :: acc
| _ -> 
  create_player_record_helper no_of_players :: 
  create_player_record (no_of_players-1) acc

let player_records_list number = 
  let num = int_of_string number in
  create_player_record num [] |>
  List.rev

(* Initialize Player Function End *)

let get_current_location player = player.current_location

let get_player_id player = player.id

let get_all_properties player = player.properties

let get_current_amt player = player.current_amount

(** str function for representation of the player  *)