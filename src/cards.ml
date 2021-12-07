open Yojson.Basic.Util
open State
open Player

type card_id = int

type card_name = string

type card_action = string

type action_phrase = string list

exception UnknownAction

type card = {
  card_id : card_id;
  card_name : card_name;
  card_message : string;
  card_action : card_action
}

type deck = {
  chance_cards : card array;
  cc_cards : card array
}

(* helper functions *)

(* deck_of_json parses the one deck of cards. *)
let deck_of_json j =
  {
    card_id = j |> member "card_id" |> to_int;
    card_name = j |> member "card_name" |> to_string;
    card_message = j |> member "card_message" |> to_string;
    card_action = j |> member "card_action" |> to_string;
  }

(* chance_cc_of_json parses the deck of chance and cc cards. *)
let chance_cc_of_json j = 
  {
    chance_cards = j |> member "chance" |> to_list |> List.map deck_of_json |> Array.of_list;
    cc_cards = j |> member "community chest" |> to_list |> List.map deck_of_json |> Array.of_list;
  }

(* end of helper functions*)

let name c = c.card_name

let id c = c.card_id

let message c = c.card_message

let action c = c.card_action

let chance_deck d = d.chance_cards

let cc_deck d = d.cc_cards

let next_chance_card d = 
  let random_i = Stdlib.Random.int (Array.length d.chance_cards) in
  d.chance_cards.(random_i)

let next_cc_card d = 
  let random_i = Stdlib.Random.int (Array.length d.cc_cards) in
  d.cc_cards.(random_i)

let move_action slst state = 
  let current_id = current_player_id state in
  let plist = player_list state in
  let current_player = get_player_by_id current_id plist in
  let others = get_others_by_id current_id plist in
  match slst with 
  | [] -> raise UnknownAction
  | [h] -> change_location current_player (int_of_string h) :: others
  (* case where player moves a to a specific property_id. *)
  | h :: amt :: t -> move_player current_player (int_of_string amt) :: others
  (* case where player moves a specific number of spaces. *)

let pay_action slst state = 
  let current_id = current_player_id state in
  let plist = player_list state in
  let current_player = get_player_by_id current_id plist in
  let others = get_others_by_id current_id plist in
  match slst with 
  | [] -> raise UnknownAction
  | [h] -> deduct_amt current_player (int_of_string h) :: others
  (* case where player pays bank brbs *)
  | h :: amt :: t -> 
    pay_all current_player others (int_of_string amt)
  (* case where player pays all players brbs *)

let collect_action slst state = 
  let current_id = current_player_id state in
  let plist = player_list state in
  let current_player = get_player_by_id current_id plist in
  let others = get_others_by_id current_id plist in
  match slst with 
  | [] -> raise UnknownAction
  | [h] -> increment_amt current_player (int_of_string h) :: others
  (* case where player collects brbs from the bank *)
  | h :: amt :: t -> 
    collect_all current_player others (int_of_string amt)
  (* case where player collects brbs from all players *)

(* [parse_action_helper c state] is the helper function for [parse_action]. Will
  return a player list with updated attributes. *)
let parse_action_helper c state =
  let action_message = action c in
    let list =
      List.filter (fun x -> x <> "") (String.split_on_char ' ' action_message)
    in
    match list with
    | [] -> raise UnknownAction
    | h :: t -> 
      if h = "move" then move_action t state
      else if h = "pay" then pay_action t state
      else collect_action t state

let parse_action c state = 
  let players = parse_action_helper c state in
  set_player_list state players

let draw_chance d state = 
  let card = next_chance_card d in 
  let _ = print_endline ((name card) ^ " " ^ (message card)) in
  parse_action card state

let draw_cc d state = 
  let card = next_cc_card d in 
  let _ = print_endline ((name card) ^ " " ^ (message card)) in
  parse_action card state