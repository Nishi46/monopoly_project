open OUnit2
open Yojson.Basic.Util
open Monopoly
open Player

exception EmptyList

let player_id_test
(name : string)
(indv_player: player)
(expected_output : int) : test =
name >:: fun _ -> 
assert_equal expected_output (get_player_id indv_player)  ~printer: string_of_int 

let player_current_amt_test
(name : string)
(indv_player: player)
(expected_output : amount) : test =
name >:: fun _ -> 
assert_equal expected_output (get_current_amt indv_player)

let player_current_location_test
(name : string)
(indv_player: player)
(expected_output : int) : test =
name >:: fun _ -> 
assert_equal expected_output (get_current_location indv_player)

let player_properties_test
(name : string)
(indv_player: player)
(expected_output : string list) : test =
name >:: fun _ -> 
assert_equal expected_output (get_all_properties indv_player)

let move_player_test
(name : string)
(indv_player: player)
(moves: int)
(expected_output : int) : test =
name >:: fun _ -> (move_player indv_player moves);
assert_equal ~printer: string_of_int expected_output (get_current_location indv_player) 

let test_player_records_1 = player_records_list "4"

let test_player_records_2 = player_records_list "3"

let test_player_records_3 = player_records_list "2"

let first_player (lst : player list) =
  match lst with
  | [] -> raise EmptyList
  | h :: t -> h

(* let second_player (lst : player list) =
  match lst with
  | [] -> raise EmptyList
  | h :: s :: t -> s

let third_player (lst : player list) =
    match lst with
    | [] -> raise EmptyList
    | h :: s :: t -> s *)

(* let test_move_player =  *)
let player_tests =[
  player_id_test "test1 for player id" (first_player test_player_records_2) 1; 
  (* player_id_test "test2 for player id" (second_player test_player_records_2) 2; *)
  player_current_amt_test "test1 for player amount" (first_player test_player_records_1) 1500;
  player_current_location_test "test1 for current_location" (first_player test_player_records_1) 1;
  (* move_player (first_player test_player_records_1) 3;  *)
  (* move_player_test "test for moving player" (first_player test_player_records_1) 39 40; *)
  (* move_player_test "test for moving player" (first_player test_player_records_1) 39 40; *)
  move_player_test "test for moving player" (first_player test_player_records_1) 40 1; 

]
let suite =
  "test suite for players"
  >::: List.flatten [ player_tests ]
