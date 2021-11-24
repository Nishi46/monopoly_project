open Yojson.Basic.Util
open State

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

let next_chance_card d = 
  let random_i = Stdlib.Random.int (Array.length d.chance_cards) in
  d.chance_cards.(random_i)

let next_cc_card d = 
  let random_i = Stdlib.Random.int (Array.length d.cc_cards) in
  d.cc_cards.(random_i)

let move_action slst state = 
  match slst with 
  | [] -> UnknownAction
  | [h] -> UnknownAction (* TODO: case where player moves to a specific space id *)
  | h :: t -> UnknownAction (* TODO: case where player moves a specific number of spaces *)

let pay_action slst state = 
  match slst with 
  | [] -> UnknownAction
  | [h] -> UnknownAction (* TODO: case where player pays bank brbs *)
  | h :: t -> UnknownAction (* TODO: case where player pays all players brbs *)

let collect_action slst state = 
  match slst with 
  | [] -> UnknownAction
  | [h] -> UnknownAction (* TODO: case where player collects brbs from the bank *)
  | h :: t -> UnknownAction (* TODO: case where player collects brbs from all players *)

let parse_action c state =
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

let draw_chance d state = 
  let card = next_chance_card d in 
  let _ = print_endline ((name card) ^ " " ^ (message card)) in
  parse_action card state

let draw_cc d state = 
  let card = next_cc_card d in 
  let _ = print_endline ((name card) ^ " " ^ (message card)) in
  parse_action card state