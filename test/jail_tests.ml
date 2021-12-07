open OUnit2
open Yojson.Basic.Util
open Monopoly
open Jail

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
(expected_output : Jail.p) : test = 
name >:: fun _ -> assert_equal expected_output (Jail.from_json json)

let properties_test
(name : string)
(c : Jail.p)
(expected_output : Jail.jail list) : test =
name >:: fun _ ->
assert_equal ~cmp:cmp_set_like_lists 
expected_output (Jail.properties c)

let jail_name_test
(name : string)
(c : Jail.p)
(prop_id : Jail.property_id)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Jail.name c prop_id)

let jail_id_test
(name : string)
(c : Jail.p)
(prop : Jail.jail)
(expected_output : Jail.property_id) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Jail.jail_id prop)

let j = Jail.from_json (Yojson.Basic.from_file "data/jail.json")

let jail_tests = [
  jail_name_test "name test 1" j 41 "Jail";
  jail_id_test "id test 1" j ( j |> Jail.properties |> List.hd) 41;
]

let suite =
  "test suite for nothing properties"
  >::: List.flatten [ jail_tests ]