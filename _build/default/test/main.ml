open OUnit2
open Yojson.Basic.Util
open Monopoly
open Property
open Property_tests
open Chancecc
open Chance_cc_tests
open Player
open Player_tests
open Luxury_income_go
open Luxury_income_go_tests
open Cards
open Cards_tests
open State
open State_tests

let property_suite = Property_tests.suite
let chance_cc_suite = Chance_cc_tests.suite
let player_suite = Player_tests.suite
let lux_inc_go_suite = Luxury_income_go_tests.suite
let nothing_suite = Nothing_tests.suite
let cards_suite = Cards_tests.suite

let state_suite = State_tests.suite 

let _ = run_test_tt_main property_suite
let _ = run_test_tt_main chance_cc_suite
let _ = run_test_tt_main player_suite
let _ = run_test_tt_main lux_inc_go_suite
let _ = run_test_tt_main nothing_suite
let _ = run_test_tt_main cards_suite
let _ = run_test_tt_main state_suite



