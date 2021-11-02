open Monopoly
open Prompts
open Player

(* This file stores all the game helper and execution functions needed to run 
   the game. *)

(* Helper Functions *)

(* [get_player_input x] takes in user input. If [x] is one of "1","2","3","4" 
   [get_player_input x] returns x. If x is a different value, the user is 
   prompted for another input and [get_player_input x] is called again until 
   a valid input is provided.*)
let rec get_player_input = function 
   | "2" -> "2"
   | "3" -> "3"
   | "4" -> "4"
   | _ -> 
      print_endline "Invalid value. Pick a number 1-4 and press ENTER.";
      let y = read_line() in get_player_input y

(* TODO: Temporarily return strings, later on change to intitialize players.*)

(******************************************************************************)

(* Game Execution Functions *)

(* [setup ()] starts the game by introducing the players, displaying instructions
   and getting user input on how many players are participating. *)
let setup () = 
   print_endline
     "\nWelcome to Cornell Monopoly! Any person any building!\n";
   print_endline
     "Please play with full screen to get the best experience.\n";
 
   (* Welcome players and instructions. *)
   (* TODO: come up with more creative name for GO. *)
   print_endline objective_pmpt;
   let _ = read_line() in
   print_endline "Here’s how to play: \n";
   print_endline instructions_pmpt;
   let _ = read_line() in
   print_endline go_pmpt;
   print_endline property_pmpt;
   print_endline rent_pmpt;
   let _ = read_line() in
   print_endline chance_comm_pmpt;
   print_endline jail_pmpt;
   let _ = read_line() in
   print_endline parking_pmpt;
   print_endline house_hotel_pmpt;
   print_endline bankrupt_pmpt;
   let _ = read_line() in
   print_endline how_win_pmpt
   
let initialize () = 
   let _ = read_line() in
   print_endline "How many players? Pick a number 2-4 and press ENTER.\n";
   print_string "> ";
   (* Get number of players and initialize them. *)
   let x = read_line() in 
   let user_input = get_player_input x in
   let players = Player.player_records_list user_input in
   print_endline ("You have chosen " ^ user_input ^ " players.\n")