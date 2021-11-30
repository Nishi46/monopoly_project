(* Representation of player data.
    This module represents the player data. *)
type player
(* The abstract type that represents a player. *)

type player_id = int
(* The type of player's id. *)

exception InvalidPlayerNumber
(* exception that is thrown when an invalid player number is provided. *)

type amount = int
(* The type of the amount that each player has. *)

val player_records_list : string -> player list
(* [player_records_list number] is list of [no_of_players] player types, each 
   player with a distinct id between 1-4. *)

val get_current_location : player -> int
(** [get_current_location player] returns the current location
 of the player on the board. *)

val get_player_id : player -> player_id
(* [get_player_id player] returns the player id
 of the selected player. *)

val get_all_properties : player -> string list
(* [get_all_properties player] returns all the properties that the player owns*)

val get_current_amt : player -> amount
(* [get_current_amt player] returns the current amount that the player
 has in their game current account *)

val move_player : player -> int -> unit 
    
 

