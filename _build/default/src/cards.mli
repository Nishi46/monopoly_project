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

val name : card -> card_name
(* [name c] is the name of the card. *)

val id : card -> card_id
(* [id c] is the id of the card. *)

val message : card -> string 
(* [message c] is the message of the card. *)

val action : card -> card_action
(* [action c] is the action of the card. *)

val next_card : deck -> card
(* [next_card d] is the next card in the deck. *)