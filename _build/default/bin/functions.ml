open Prompts

(* This file stores all the game helper and execution functions needed to run 
   the game. *)

(* Helper Functions *)

(* [initialize_players x] takes in user input and initalizes a player type for 
   each of [x] number of players if [x] is one of "1","2","3","4". 
   If x is a different value, the user is prompted for another input and 
   [initialize_players x] is called again until a valid input is provided. *)

(* TODO: Temporarily return strings, later on change to intitialize players.*)
let rec initialize_players = function
    | "2" -> print_endline "You have chosen 2 players.\n"
    | "3" -> print_endline "You have chosen 3 players.\n"
    | "4" -> print_endline "You have chosen 4 players.\n"
    | _ -> 
      print_endline "Invalid value. Pick a number 1-4 and press ENTER.";
      let y = read_line() in initialize_players y

(******************************************************************************)

(* Game Execution Functions *)

(* [setup ()] starts the game by introducing the players, displaying instructions
   and getting user input on how many players are participating. *)
let setup () = 
   print_endline
     "\nWelcome to Cornell Monopoly! Any person any building!\n";
 
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
   print_endline how_win_pmpt;
   let _ = read_line() in
 
   print_endline "How many players? Pick a number 2-4 and press ENTER.\n";
   print_string "> ";
   (* Get number of players and initialize them. *)
   (* TODO: Temporarily return strings, later on change to intitialize players.*)
   let x = read_line() in initialize_players x