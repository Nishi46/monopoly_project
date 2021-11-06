open OUnit2
open Yojson.Basic.Util
open Monopoly
open Chancecc

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
(expected_output : Chancecc.c) : test = 
name >:: fun _ -> assert_equal expected_output (Chancecc.from_json json)

let properties_test
(name : string)
(c : Chancecc.c)
(expected_output : Chancecc.chance_cc_space list) : test =
name >:: fun _ ->
assert_equal ~cmp:cmp_set_like_lists 
expected_output (Chancecc.properties c)

let chancecc_name_test
(name : string)
(c : Chancecc.c)
(prop_id : Chancecc.property_id)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Chancecc.name c prop_id)

let chancecc_id_test
(name : string)
(c : Chancecc.c)
(prop : Chancecc.chance_cc_space)
(expected_output : Chancecc.property_id) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Chancecc.id prop)

let c = Chancecc.from_json (Yojson.Basic.from_file "data/chance_community_chest.json")

let chance_cc_tests = [
  chancecc_id_test "id test 1" c ( c |> Chancecc.properties |> List.hd) 3;
  chancecc_id_test "id test 2" c ( c |> Chancecc.properties |> List.rev |> List.hd) 37;
  chancecc_name_test "name test 1" c 18 "Community Chest";
  chancecc_name_test "name test 2" c 23 "Chance";
]

let suite =
  "test suite for properties"
  >::: List.flatten [ chance_cc_tests ]