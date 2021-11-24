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

type t = 
{
  status : string;
  players : player list;
  board_spaces : board_space list;
  current_player_id : int; 
  jailed_player_ids : player_id list; 

}

let get_id = function 
| P b -> Property.p_id b 
| LIG b -> Luxury_income_go.id b 
| CC b -> Chancecc.id b 

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

let get_board_spaces = 
  let p_lst = Property.from_json (Yojson.Basic.from_file "data/property_test.json") |> Property.properties |> property_to_board in 
  let lig_lst = Luxury_income_go.from_json (Yojson.Basic.from_file "data/luxury_income_go.json") |> Luxury_income_go.properties |> lig_to_board in 
  let cc_lst = Chancecc.from_json (Yojson.Basic.from_file "data/chance_community_chest.json") |> Chancecc.properties |> cc_to_board
in p_lst @ lig_lst @ cc_lst |> List.sort compare_board_spaces

let init_state player_list = { 
  status = "start";
  players = player_list;
  board_spaces = get_board_spaces;
  current_player_id = 0;
  jailed_player_ids = []
}