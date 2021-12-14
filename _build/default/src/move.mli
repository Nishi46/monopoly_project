open State
open Cards
open Player
(* Representation of game turn.
    This module represents one turn of the game. *)

val take_tax : Player.player -> int -> Player.player
(* [take_tax s p i] determines whether or not a player has landed on a tax tile.
    if so, the corresponding deductions are made from their currency. *)

val roll_dice : State.t -> player_id -> State.t
(* [roll_dice s i] generates two die rolls randomly and returns a board with 
  the player in the new position. The player performs an action depending on 
  which position they land on *)