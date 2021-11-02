open Monopoly
open Prompts
open Functions
open Player

(* Execute the game engine. *)
let () = setup ()
let () = initialize ()
let _ = print_endline welcome_pmpt