open OUnit2
open Yojson.Basic.Util
open Monopoly
open Luxury_income_go

(** CITED: A2
[cmp_set_like_lists lst1 lst2] compares two lists to see whether
they are equivalent set-like lists. That means checking two things.
First, they must both be {i set-like}, meaning that they do not
contain any duplicates. Second, they must contain the same elements,
though not necessarily in the same order. *)
let cmp_set_like_lists lst1 lst2 =
  let uniq1 = List.sort_uniq compare lst1 in
  let uniq2 = List.sort_uniq compare lst2 in
  List.length lst1 = List.length uniq1
  && List.length lst2 = List.length uniq2
  && uniq1 = uniq2

let from_json_test
(name : string)
(json : Yojson.Basic.t)
(expected_output : Luxury_income_go.special) : test = 
name >:: fun _ -> assert_equal expected_output (Luxury_income_go.from_json json)

let properties_test
(name : string)
(s : Luxury_income_go.special)
(expected_output : Luxury_income_go.special_space list) : test =
name >:: fun _ ->
assert_equal ~cmp:cmp_set_like_lists 
expected_output (Luxury_income_go.properties s)

let lux_inc_go_name_test
(name : string)
(s : Luxury_income_go.special)
(prop_id : Luxury_income_go.property_id)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Luxury_income_go.name s prop_id)

let lux_inc_go_id_test
(name : string)
(s : Luxury_income_go.special)
(prop : Luxury_income_go.special_space)
(expected_output : Luxury_income_go.property_id) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Luxury_income_go.id prop)

let s = Luxury_income_go.from_json (Yojson.Basic.from_file "data/luxury_income_go.json")

let lux_inc_go_tests = [
  lux_inc_go_id_test "id test 1" s ( s |> Luxury_income_go.properties |> List.hd) 1;
  lux_inc_go_id_test "id test 2" s ( s |> Luxury_income_go.properties |> List.rev |> List.hd) 39;
  lux_inc_go_name_test "name test 1" s 1 "GO";
  lux_inc_go_name_test "name test 2" s 39 "Luxury Tax";
]

let suite =
  "test suite for properties"
  >::: List.flatten [ lux_inc_go_tests ]