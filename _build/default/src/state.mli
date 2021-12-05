open Player
open Property 
open Luxury_income_go
open Chancecc
open Jail
open Nothing
(* Representation of game state.
    This module represents the state of the game. *)

type board_space 
(** The abstract types representing a board space of the game. *)

type t 
(** The abstract types representing the state of the game. *)

val init_state: player list -> t
(** [init_state p] returns the initial state of the game with players p *)

val init_state': int -> t
(** [init_state' p] returns the initial state of the game with number of players p *)

val status: t -> string 
(** [status t] returns the status of the state t *)

val board_spaces: t -> board_space list  
(** [board_spaces t] returns the board spaces of the state t *)

val player_list: t -> player list  
(** [player_list t] returns the status of the state t *)

val jailed_player_ids: t -> player_id list  
(** [jailed_player_ids t] returns the status of the state t *)

val current_player_id: t -> player_id 
(** [current_player_id t] returns the status of the state t *)

val set_status: t -> string -> t
(** [set_status t s] returns the state t with status s *)

val set_board_spaces: t -> board_space list  -> t
(** [board_spaces t s] returns the state t with board_spaces s *)

val set_player_list: t -> player list -> t
(** [set_player_list t s] returns the state t with player_list s *)

val set_jailed_player_ids: t -> player_id list -> t  
(** [jailed_player_ids t s] returns state t with jailed_player_ids s*)

val set_current_player_id: t -> player_id -> t
(** [set_current_player_id t s] returns state t with current_player_id s *)

val check_bankruptcy: t -> t
(** [check_bankruptcy t] returns new state t' with bankrupt players removed *)

val pass_go: t -> t 
(** [pass_go t] returns new state t' with players who pass go gaining income *)