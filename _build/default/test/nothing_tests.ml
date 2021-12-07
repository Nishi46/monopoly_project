open OUnit2
open Yojson.Basic.Util
open Monopoly
open Nothing

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
(expected_output : Nothing.p) : test = 
name >:: fun _ -> assert_equal expected_output (Nothing.from_json json)

let properties_test
(name : string)
(c : Nothing.p)
(expected_output : Nothing.nothing list) : test =
name >:: fun _ ->
assert_equal ~cmp:cmp_set_like_lists 
expected_output (Nothing.properties c)

let nothing_name_test
(name : string)
(c : Nothing.p)
(prop_id : Nothing.property_id)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Nothing.name c prop_id)

let nothing_id_test
(name : string)
(c : Nothing.p)
(prop : Nothing.nothing)
(expected_output : Nothing.property_id) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Nothing.nothing_id prop)

let n = Nothing.from_json (Yojson.Basic.from_file "data/nothing.json")

let nothing_tests = [
  nothing_name_test "name test 1" n 21 "Free Parking";
  nothing_name_test "name test 2" n 11 "Just Visiting";
  nothing_id_test "id test 1" n ( n |> Nothing.properties |> List.hd) 21;
  nothing_id_test "id test 2" n ( n |> Nothing.properties |> List.rev |> List.hd) 11;
]

let suite =
  "test suite for nothing properties"
  >::: List.flatten [ nothing_tests ]