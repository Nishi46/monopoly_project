open OUnit2
open Yojson.Basic.Util
open Monopoly
open Cards

let json_test
(name : string)
(json : Yojson.Basic.t)
(expected_output : Cards.deck) : test = 
name >:: fun _ -> assert_equal expected_output (Cards.chance_cc_of_json json)

let card_name_test
(name : string)
(c : Cards.card)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Cards.name c)

let card_id_test
(name : string)
(c : Cards.card)
(expected_output : Cards.card_id) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Cards.id c)

let card_message_test
(name : string)
(c : Cards.card)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Cards.message c)

let card_action_string_test
(name : string)
(c : Cards.card)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Cards.action c)

let card_next_chance_test
(name : string)
(d : Cards.deck)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (d |> Cards.next_chance_card |> Cards.name)

let card_next_cc_test
(name : string)
(d : Cards.deck)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (d |> Cards.next_cc_card |> Cards.name)

let move_loc_card_test
(name : string)
(c : Cards.card)
(s : State.t)
(expected_output : int) : test =
let state' = Cards.parse_action c s in
let player_list = State.player_list state' in
let current_p_id = State.current_player_id state' in
let current_p = Player.get_player_by_id current_p_id player_list in
let loc = Player.get_current_location current_p in
name >:: fun _ -> 
assert_equal ~printer: (string_of_int)
expected_output loc

let move_space_card_test
(name : string)
(c : Cards.card)
(s : State.t)
(expected_output : int) : test =
let state' = Cards.parse_action c s in
let player_list = State.player_list state' in
let current_p_id = State.current_player_id state' in
let current_p = Player.get_player_by_id current_p_id player_list in
let loc = Player.get_current_location current_p in
name >:: fun _ -> 
assert_equal ~printer: (string_of_int)
expected_output loc

let player_pay_card_test
(name : string)
(c : Cards.card)
(s : State.t)
(expected_output : int) : test =
let state' = Cards.parse_action c s in
let player_list = State.player_list state' in
let current_p_id = State.current_player_id state' in
let current_p = Player.get_player_by_id current_p_id player_list in
let balance = Player.get_current_amt current_p in
name >:: fun _ -> 
assert_equal ~printer: (string_of_int)
expected_output balance

let pay_all_player_test
(name : string)
(c : Cards.card)
(s : State.t)
(expected_output : int) : test =
let state' = Cards.parse_action c s in
let player_list = State.player_list state' in
let current_p_id = State.current_player_id state' in
let current_p = Player.get_player_by_id current_p_id player_list in
let balance = Player.get_current_amt current_p in
name >:: fun _ -> 
assert_equal ~printer: (string_of_int)
expected_output balance

let player_collect_card_test
(name : string)
(c : Cards.card)
(s : State.t)
(expected_output : int) : test =
let state' = Cards.parse_action c s in
let player_list = State.player_list state' in
let current_p_id = State.current_player_id state' in
let current_p = Player.get_player_by_id current_p_id player_list in
let balance = Player.get_current_amt current_p in
name >:: fun _ -> 
assert_equal ~printer: (string_of_int)
expected_output balance

(*****************************************************************************)
(* Testing Basic Cards + Decks *)
let deck = 
  Cards.chance_cc_of_json (Yojson.Basic.from_file "data/cards.json")
let chance = chance_deck deck
let cc = cc_deck deck

let test1_cc_card = cc.(0)
let name_1 = "Your friend finally returned the money they borrowed from you."
let message_1 = "Collect 100 BRBs profit."
let action_1 = "collect 100"

let test2_cc_card = cc.(7)
let name_2 = "You win your club's raffle ticket"
let message_2 = "Collect 200 BRBs profit"
let action_2 = "collect 200"

let test1_chance_card = chance.(5)
let name_3 = 
  "You see your friend waving at you at the clock tower. You run to greet them."
let message_3 = "Go to McGraw Tower."
let action_3 = "move 6"

let test2_chance_card = chance.(14) 
let name_4 = "Its Friday and you are craving poke."
let message_4 = "Advance to Pokelava."
let action_4 = "move 19"

(*****************************************************************************)
(* Testing Draw Card with Deck containing only 1 card *)
let deck_one = 
  Cards.chance_cc_of_json (Yojson.Basic.from_file "data/cards_test.json")
let chance_one = chance_deck deck
let cc_one = cc_deck deck

(*****************************************************************************)
(* Testing Action Parsing *)
let test_state = State.init_state' 4 
let p1_turn = State.set_current_player_id test_state 1
let p2_turn = State.set_current_player_id p1_turn 2
let p3_turn = State.set_current_player_id p2_turn 3
let p4_turn = State.set_current_player_id p3_turn 4
let move_loc_card1 = chance.(10)
let move_loc_card2 = cc.(9)
let move_space_card = chance.(5)
let pay_card1 = cc.(8)
let pay_card2 = chance.(11)
let collect_card1 = chance.(3)

(*****************************************************************************)

let basic_cards_tests = [
  card_name_test "cc card 1 name" test1_cc_card name_1;
  card_name_test "cc card 2 name" test2_cc_card name_2;
  card_name_test "chance card 1 name" test1_chance_card name_3;
  card_name_test "chance card 2 name" test2_chance_card name_4;
  card_id_test "cc card 1 id" test1_cc_card 0;
  card_id_test "cc card 2 id" test2_cc_card 7;
  card_id_test "chance card 1 id" test1_chance_card 5;
  card_id_test "chance card 2 id" test2_chance_card 14; 
  card_message_test "cc card 1 message" test1_cc_card message_1;
  card_message_test "cc card 2 message" test2_cc_card message_2;
  card_message_test "chance card 1 message" test1_chance_card message_3;
  card_message_test "chance card 2 message" test2_chance_card message_4;
  card_action_string_test "cc card 1 action string" test1_cc_card action_1;
  card_action_string_test "cc card 2 action string" test2_cc_card action_2;
  card_action_string_test "chance card 1 action string" test1_chance_card action_3;
  card_action_string_test "chance card 2 action string" test2_chance_card action_4;
  card_next_chance_test "draw chance" deck_one "You want to go shopping!";
  card_next_cc_test "draw cc" deck_one "Cornell increased tuition."
]

let action_parse_tests = [
  move_loc_card_test "player 1 move to loc 41" move_loc_card2 p1_turn 41;
  move_loc_card_test "player 1 move to loc 12" move_loc_card1 p1_turn 12;
  move_space_card_test "player 1 move to 6" move_space_card p1_turn 6;
  player_pay_card_test "player 1: 1500 -> 1400?" pay_card1 p1_turn 1400;
  player_pay_card_test "player 2: 1500 -> 1470?" pay_card2 p2_turn 1470;
  (*pay_all_player_test "player 3: 1500 -> 1200" pay_card1 p3_turn 1200;*)
  player_collect_card_test "player 4: 1500 -> 1650?" collect_card1 p4_turn 1650;
]

let suite =
  "test suite for cards"
  >::: List.flatten [ 
    basic_cards_tests;
    action_parse_tests;
  ]