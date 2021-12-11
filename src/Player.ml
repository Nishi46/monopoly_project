type player_id = int

type amount = int

exception InvalidPlayerNumber

type player = {
  id : player_id;
  mutable current_amount : amount;
  mutable properties : int list;
  mutable current_location : int;
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

let rec get_player_by_id id lst = 
  match lst with
  | [] -> raise InvalidPlayerNumber
  | h :: t -> if h.id = id then h else get_player_by_id id t

let rec get_others_by_id id lst = 
  match lst with
  | [] -> lst
  | h :: t -> 
    if h.id = id then get_others_by_id id t 
    else h :: get_others_by_id id t 

(** str function for representation of the player  *)

let deduct_amt renter amount =
  renter.current_amount <- renter.current_amount - amount;
  renter

let increment_amt renter amount = 
  renter.current_amount <- renter.current_amount + amount;
  renter

let pay_rent_helper rent_payer rent_taker rent = 
  [deduct_amt (rent_payer) (rent); increment_amt (rent_taker) (rent)]

let collect_money_from_bank player amount =
  increment_amt player amount

let check_bankcrupty player =
 if player.current_amount < 0 then true else false

let change_location player property_id =
  player.current_location <- property_id; player

let helper_player_moves (player) moves = 
    if (player.current_location + moves) < 0 then 40 - (((player.current_location + moves) * -1) mod 40)
    else if (player.current_location + moves)> 40 
    then (player.current_location + moves) mod 40 else (player.current_location + moves)

let move_player player moves =
  player.current_location <- helper_player_moves player moves; player

let rec pay_all player plist amt =
  match plist with
  | [] -> player :: plist
  | h :: t -> 
    (pay_rent_helper player h amt) @ (pay_all player t amt)

  let rec collect_all player plist amt =
    match plist with
    | [] -> player :: plist
    | h :: t -> 
      (pay_rent_helper h player amt) @ (collect_all player t amt)

let properties p = p.properties
let remove_property p p_id = 
  let new_plist = List.filter (fun x -> x <> p_id) p.properties in 
  {p with properties = new_plist}

let add_property p p_id = 
  let new_plist = p_id :: p.properties in 
  {p with properties = new_plist}