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
let property_suite = Property_tests.suite
let chance_cc_suite = Chance_cc_tests.suite
let player_suite = Player_tests.suite
let lux_inc_go_suite = Luxury_income_go_tests.suite

let _ = run_test_tt_main property_suite
let _ = run_test_tt_main chance_cc_suite
let _ = run_test_tt_main player_suite
let _ = run_test_tt_main lux_inc_go_suite



