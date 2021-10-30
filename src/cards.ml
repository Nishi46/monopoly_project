open Yojson.Basic.Util

type card_id = int

type card_name = string

type card_action = string

exception NoMoreCards

type card = {
  card_id : card_id;
  card_name : card_name;
  card_message : string;
  card_action : card_action
}

type deck = card list 

let name c = c.card_name

let id c = c.card_id

let message c = c.card_message

let action c = c.card_action

let next_card d = 
  match d with 
  | [] -> raise NoMoreCards
  | h :: _ -> h