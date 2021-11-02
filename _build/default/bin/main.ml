open Monopoly
open Prompts
open Functions
open Player
open Board_print

(* Execute the game engine. *)
let () = setup ()
let () = initialize ()
let _ = print_endline welcome_pmpt
let _ = print_endline board_display