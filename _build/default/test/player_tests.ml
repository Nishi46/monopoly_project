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
assert_equal expected_output (get_current_location indv_player) ~printer: string_of_int 

let player_properties_test
(name : string)
(indv_player: player)
(expected_output : int list) : test =
name >:: fun _ -> 
assert_equal expected_output (get_all_properties indv_player)
(* ~printer: string list  *)
let player_properties_test
(name : string)
(indv_player: player)
(expected_output : int list) : test =
name >:: fun _ -> 
assert_equal expected_output (get_all_properties indv_player) 
(* ~printer: string list  *)

let move_player_test
(name : string)
(indv_player: player)
(moves: int)
(expected_output : int) : test =
name >:: fun _ -> (move_player indv_player moves);
assert_equal ~printer: string_of_int expected_output (get_current_location indv_player) 

let get_player_by_id_test
(name : string)
(player_id: player_id)
(player_list: player list)
(expected_output : player) : test =
name >:: fun _ ->
assert_equal expected_output (get_player_by_id player_id player_list)

let get_others_by_id_test
(name : string)
(player_id: int)
(player_list: player list)
(expected_output : player list) : test =
name >:: fun _ ->
assert_equal expected_output (get_others_by_id player_id player_list)

let check_bankcrupty_test 
(name : string)
(player: player)
(expected_output : bool) : test =
name >:: fun _ ->
assert_equal expected_output (check_bankcrupty player)

let test_player_records_1 = player_records_list "4"
let test_player_records_2 = player_records_list "3"
let test_player_records_3 = player_records_list "2"
let test_player_records_4 = player_records_list "4"
let test_player_records_5 = player_records_list "4"
let test_player_records_6 = player_records_list "4"
let test_player_records_7 = player_records_list "4"
let test_player_records_8 = player_records_list "4"
let test_player_records_9 = player_records_list "4"
let test_player_records_10 = player_records_list "4"
let test_player_records_11 = player_records_list "4"
let test_player_records_12 = player_records_list "4"
let test_player_records_13 = player_records_list "4"

let first_player (lst : player list) =
  match lst with
  | [] -> raise EmptyList
  | h :: t -> h

let second_player (lst : player list) =
  match lst with
  | [] -> raise EmptyList
  | h :: s :: t -> s
  | _ -> failwith "doesn't matter"

let third_player (lst : player list) =
    match lst with
    | [] -> raise EmptyList
    | h :: s :: t :: r -> t
    | _ -> failwith "doesn't matter"

let fourth_player (lst : player list) =
      match lst with
      | [] -> raise EmptyList
      | h :: s :: t :: r -> r
      | _ -> failwith "doesn't matter"

let only_player_2_3_from_3 (lst: player list) =
  match lst with 
  | [] -> raise EmptyList
  | h :: t -> t 

let only_player_1_3_from_3 (lst: player list) =
    match lst with 
    | [] -> raise EmptyList
    | h ::s :: t -> h :: t
    | _ -> failwith "doesnt matter"
    

let adding_property_to_p1 = add_property (first_player test_player_records_2) 2   
let player_tests =[
  player_id_test "test1 for player id" (first_player test_player_records_2) 1; 
  player_current_amt_test "test1 for player amount" (first_player 
  test_player_records_6) 1500;
  player_current_location_test "test1 for current_location" (first_player 
  test_player_records_1) 1;
  player_properties_test "test1 for player properties" (first_player 
  test_player_records_1) [];
  player_properties_test "test2 for player properties" (first_player
   test_player_records_2) [];
  get_player_by_id_test "test for getting player by id 1"
  1 (test_player_records_2) (first_player (test_player_records_2));
  move_player_test "test for moving player2" (first_player test_player_records_1) 
  39 40;
  move_player_test "test for moving player3" (first_player test_player_records_4) 
  40 1; 
 get_player_by_id_test "test for getting player by id 1"
 2 (test_player_records_2) (second_player (test_player_records_2));
 get_player_by_id_test "test for getting player by id 1"
 3 (test_player_records_2) (third_player  (test_player_records_2));
 get_others_by_id_test "test for getting other players by id 1" 2 
 test_player_records_2 (only_player_1_3_from_3 test_player_records_2);
  check_bankcrupty_test "checking bankcrupty after deducting amount" 
  (deduct_amt (first_player (test_player_records_3)) 200) false;
  check_bankcrupty_test "checking bankcrupty after deducting amount" 
  (deduct_amt (first_player (test_player_records_2)) 1501) true;
  check_bankcrupty_test "checking bankcrupty after incrementing amount" 
  (increment_amt (deduct_amt (first_player (test_player_records_1)) 1501) 1502) 
  false;
  player_current_amt_test "test1 for pay rent helper after first player 
  pays 400 to second player" (
    first_player (pay_rent_helper (first_player test_player_records_7)
    (second_player test_player_records_7) 400)) 1100 ;
  player_current_amt_test "test2 for pay rent helper after first player 
  pays 400 to second player" 
  (second_player (test_player_records_7)) 1900 ;
  player_current_amt_test "test3 for pay rent helper after second player
   pays 400 to second player" (
    second_player (pay_rent_helper (second_player test_player_records_8)
    (first_player test_player_records_8) 500)) 2000 ;
  player_current_amt_test "test1 for collecting money from bank 200 amount" 
  (collect_money_from_bank (first_player (test_player_records_9)) 200) 1700;
  player_current_amt_test "test2 for collecting money from bank 200 amount" 
  (collect_money_from_bank (third_player (test_player_records_9)) 200) 1700;
  player_current_location_test "test1 for change location" 
  (change_location (first_player (test_player_records_10)) 4) 4 ;
  player_current_location_test "test2 for change location" 
  (change_location (third_player (test_player_records_10)) 40) 40 ;

]
let suite =
  "test suite for players"
  >::: List.flatten [ player_tests ]