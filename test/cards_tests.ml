open OUnit2
open Yojson.Basic.Util
open Monopoly
open Cards

(*let json_test
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

let deck = Cards.chance_cc_of_json (Yojson.Basic.from_file "data/cards.json")
let chance = chance_deck deck
let cc = cc_deck deck
let test1_cc_card = cc.(0)
let test2_cc_card = cc.(7)
let test1_chance_card = chance.(5)
let test2_chance_card = chance.(14) 

let cards_tests = [
  card_name_test "cc card 1 name" test1_cc_card "Get out of Jail Free!";
  card_name_test "cc card 2 name" test1_cc_card "You forgot your laptop in your dorm.";
  card_name_test "chance card 1 name" test1_cc_card "Get out of Jail Free!";
  card_name_test "chance card 2 name" test1_cc_card "Get out of Jail Free!"
]

let suite =
  "test suite for cards"
  >::: List.flatten [ cards_tests ]*)