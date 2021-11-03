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
assert_equal expected_output (get_player_id indv_player)

let test_player_records_1 = player_records_list "4"

let test_player_records_2 = player_records_list "3"

let test_player_records_3 = player_records_list "2"

let first_player (lst : player list) =
  match lst with
  | [] -> raise EmptyList
  | h :: t -> h

let player_test=[
  player_id_test "test1" (first_player test_player_records_1) 1; 
 
]