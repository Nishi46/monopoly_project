(* Representation of cards data.
    This module represents the cards data. *)

type deck
(* The abstract type that represents a deck of cards. *)

type card
(* The abstract type that represents a card. *)

type card_id = int
(* The type of the card id *)

type card_name = string
(* The type of the card name *)

type card_action = string
(* The type of the card action *)

val chance_cc_of_json : Yojson.Basic.t -> deck
(** [chance_cc_of_json j] is the chance and community chest decks that [j] 
    represents. Requires: [j] is a valid JSON property list representation. *)

val name : card -> card_name
(* [name c] is the name of the card. *)

val id : card -> card_id
(* [id c] is the id of the card. *)

val message : card -> string 
(* [message c] is the message of the card. *)

val action : card -> card_action
(* [action c] is the action of the card. *)

val chance_deck : deck -> card array
(* [chance_deck d] is the array of the chance cards. *)

val cc_deck : deck -> card array
(* [cc_deck d] is the array of the community chest cards. *)

val next_chance_card : deck -> card
(* [next_chance_card d] is the next chance card in the deck. *)

val next_cc_card : deck -> card
(* [next_cc_card d] is the next cc card in the deck. *)

val draw_chance : deck -> State.t -> State.t
(* [draw_chance] pulls a chance card, prints out the name and message, and 
   parses the action and does something depending on the card contents. *)

val draw_cc : deck -> State.t -> State.t
(* [draw_chance] pulls a chance card, prints out the name and message, and 
    parses the action and does something depending on the card contents. *)