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

(*****************************************************************************)
(* Testing Cards + Decks *)
let deck = Cards.chance_cc_of_json (Yojson.Basic.from_file "data/cards.json")
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
let name_3 = "You forgot your laptop in your dorm."
let message_3 = "Go back three spaces."
let action_3 = "move -3 spaces"

let test2_chance_card = chance.(14) 
let name_4 = "Its Friday and you are craving poke."
let message_4 = "Advance to Pokelava."
let action_4 = "move 19"

(*****************************************************************************)

let cards_tests = [
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
]

let suite =
  "test suite for cards"
  >::: List.flatten [ cards_tests ]