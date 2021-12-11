open Player
open Property 
open Luxury_income_go
open Chancecc
open Jail
open Nothing

type board_space = 
| P of property 
| LIG of special_space
| CC of chance_cc_space
| N of nothing
| J of jail 

type t = 
{
  status : string;
  players : player list;
  board_spaces : board_space list;
  current_player_id : player_id; 
  jailed_player_ids : player_id list; 

}

let get_id = function 
| P b -> Property.p_id b 
| LIG b -> Luxury_income_go.id b 
| CC b -> Chancecc.id b
| N b -> Nothing.nothing_id b 
| J b -> Jail.jail_id b 

let compare_board_spaces b1 b2 = 
  get_id b1 - get_id b2

let rec property_to_board = function
| [] -> []
| h :: t -> (P h) :: property_to_board t

let rec lig_to_board = function 
| [] -> []
| h :: t -> (LIG h) :: lig_to_board t

let rec cc_to_board = function 
| [] -> []
| h :: t -> (CC h) :: cc_to_board t

let rec nothing_to_board = function 
| [] -> []
| h :: t -> (N h) :: nothing_to_board t

let rec jail_to_board = function 
| [] -> []
| h :: t -> (J h) :: jail_to_board t

let get_board_spaces = 
  let p_lst = Property.from_json 
  (Yojson.Basic.from_file "data/property.json") 
  |> Property.properties |> property_to_board in 
  let lig_lst = Luxury_income_go.from_json 
  (Yojson.Basic.from_file "data/luxury_income_go.json") 
  |> Luxury_income_go.properties |> lig_to_board in 
  let cc_lst = Chancecc.from_json 
  (Yojson.Basic.from_file "data/chance_community_chest.json") 
  |> Chancecc.properties |> cc_to_board in
  let n_lst = Nothing.from_json 
  (Yojson.Basic.from_file "data/nothing.json") 
  |> Nothing.properties |> nothing_to_board in
  let j_lst = Jail.from_json 
  (Yojson.Basic.from_file "data/jail.json") 
  |> Jail.properties |> jail_to_board in
p_lst @ lig_lst @ cc_lst @ n_lst @ j_lst |> List.sort compare_board_spaces

let rec get_property_spaces acc = function 
| [] -> acc
| (P p) :: t -> get_property_spaces (p :: acc) t
| _ :: t -> get_property_spaces acc t

let update_property_space op np b = 
let rec helper op np acc = function 
| [] -> acc 
| (P p) :: t -> 
  if p = op then helper op np (P np :: acc) t 
  else helper op np (P op :: acc) t 
| x :: t -> helper op np (x :: acc) t in helper op np [] b 

let rec get_lig_spaces acc = function 
| [] -> acc
| (LIG p) :: t -> get_lig_spaces (p :: acc) t
| _ :: t -> get_lig_spaces acc t

let rec get_cc_spaces acc = function 
| [] -> acc
| (CC p) :: t -> get_cc_spaces (p :: acc) t
| _ :: t -> get_cc_spaces acc t

let rec get_n_spaces acc = function 
| [] -> acc
| (N p) :: t -> get_n_spaces (p :: acc) t
| _ :: t -> get_n_spaces acc t

let rec get_j_spaces acc = function 
| [] -> acc
| (J p) :: t -> get_j_spaces (p :: acc) t
| _ :: t -> get_j_spaces acc t

let init_state player_list = { 
  status = "start";
  players = player_list;
  board_spaces = get_board_spaces;
  current_player_id = 0;
  jailed_player_ids = []
}

let init_state' num_players = 
  let new_players = Player.player_records_list (string_of_int num_players) in 
  { 
    status = "start";
    players = new_players;
    board_spaces = get_board_spaces;
    current_player_id = 0;
    jailed_player_ids = []
  }

let status s = s.status 
let board_spaces s = s.board_spaces
let player_list s = s.players 
let jailed_player_ids s = s.jailed_player_ids
let current_player_id s = s.current_player_id

let set_status s status' = 
  {s with status = status'}
let set_board_spaces s board_spaces' = 
  {s with board_spaces = board_spaces'}
let set_player_list s player_list' = 
  {s with players = player_list'}
let set_jailed_player_ids s jailed_player_ids' = 
  {s with jailed_player_ids = jailed_player_ids'}
let set_current_player_id s current_player_id' = 
  {s with current_player_id = current_player_id'}

let check_bankruptcy s = 
  let new_players = 
  let f p = not (Player.check_bankcrupty p) in 
  List.filter f s.players in {s with players = new_players}
let pass_go s = 
  let new_players = 
  let rec helper acc = function 
  | [] -> acc 
  | h :: t -> let p' = 
    if Player.get_current_location h = 1 then
     (Player.collect_money_from_bank h 200) else h in 
    let acc' = p' :: acc in helper acc' t 
    in helper [] s.players in 
    {s with players = new_players}

let update_player_list op np p = 
let rec helper op np acc = function 
| [] -> acc 
| h :: t -> 
  let acc' = if h = op then np :: acc else h :: acc in 
  helper op np acc' t in helper op np [] p 

let sell_property s o b p_id =
  let p =  get_property_spaces [] s.board_spaces |> Property.make_p in 
  let prop = Property.prop p p_id in 
  let amt = Property.price p p_id in 
  let new_player = Player.increment_amt o amt in 
  let new_player = Player.remove_property new_player p_id in 
  let new_players = update_player_list o new_player s.players in 
  match b with 
  | None -> 
    let new_prop = Property.set_owner p p_id None in     
    let new_board_spaces = update_property_space prop new_prop s.board_spaces in
  {s with players = new_players; board_spaces = new_board_spaces}
  | Some buyer -> 
    let new_buyer = Player.deduct_amt buyer amt in
    let new_buyer = Player.add_property new_buyer p_id in 
    let new_buyer_id = Player.get_player_id new_buyer in  
    let new_players = update_player_list buyer new_buyer new_players in 
    let new_prop = Property.set_owner p p_id (Some new_buyer_id) in 
    let new_board_spaces = update_property_space prop new_prop s.board_spaces in
    {s with players = new_players; board_spaces = new_board_spaces}

  let buy_property s o b p_id =
    let p =  get_property_spaces [] s.board_spaces |> Property.make_p in 
    let prop = Property.prop p p_id in 
    let amt = Property.price p p_id in 
    let new_player = Player.deduct_amt b amt in 
    let new_player = Player.add_property new_player p_id in 
    let new_player_id = Player.get_player_id new_player in 
    let new_players = update_player_list b new_player s.players in 
    let new_prop = Property.set_owner p p_id (Some new_player_id) in     
    let new_board_spaces = update_property_space prop new_prop s.board_spaces in
    match o with 
    | None -> {s with players = new_players; board_spaces = new_board_spaces}
    | Some seller -> 
      let new_seller = Player.increment_amt seller amt in
      let new_seller = Player.remove_property new_seller p_id in 
      let new_players = update_player_list seller new_seller new_players in 
      {s with players = new_players; board_spaces = new_board_spaces}