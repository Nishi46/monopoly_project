open OUnit2
open Yojson.Basic.Util
open Monopoly
open Player
<<<<<<< HEAD
(* 
=======

>>>>>>> be04d4189f0411a9d1737dfdf8a48c3a571d1e73
let player1 = {id = 1; current_amount = 300; properties = "Alice Cook House"; current_location: ""}
let player_id_test = 
()
(expected_output : player.property_id) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Property.p_id prop)