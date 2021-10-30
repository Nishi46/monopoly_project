open OUnit2
open Yojson.Basic.Util
open Monopoly
open Property
open Property_tests

let property_suite = Property_tests.suite

let _ = run_test_tt_main property_suite




