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

let nothings_test
(name : string)
(p : Nothing.p)
(expected_output : Nothing.property list) : test =
name >:: fun _ ->
assert_equal ~cmp:cmp_set_like_lists 
expected_output (Nothing.properties p)

let nothing_id_test
(name : string)
(p : Nothing.p)
(prop : Nothing.property)
(expected_output : Nothing.nothing_id) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Nothing.p_id prop)

let nothing_type_test
(name : string)
(p : Nothing.p)
(prop_id : Nothing.property_id)
(expected_output : Nothing.property_type) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Nothing.p_type p prop_id)
(*
let property_color_test
(name : string)
(p : Property.p)
(prop_id : Property.property_id)
(expected_output : Property.color) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Property.color p prop_id)

let property_name_test
(name : string)
(p : Property.p)
(prop_id : Property.property_id)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Property.name p prop_id)

let property_price_test
(name : string)
(p : Property.p)
(prop_id : Property.property_id)
(expected_output : int) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Property.price p prop_id)

let property_rent_test
(name : string)
(p : Property.p)
(prop_id : Property.property_id)
(expected_output : int) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Property.rent p prop_id)

let property_owner_test
(name : string)
(p : Property.p)
(prop_id : Property.property_id)
(expected_output : int option) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> match x with Some h -> string_of_int h | None -> "Unowned")
expected_output (Property.owner p prop_id) *)
let p = Nothing.from_json (Yojson.Basic.from_file "data/nothing.json")
(* let p_set_owner1 = Property.set_owner p 2 5
let p_set_owner2 = Property.set_owner p 4 1 *)
let nothing_tests = [
  nothing_id_test "test 1" p (p |> Nothing.properties |> List.hd) 21;
  nothing_type_test "test 2" p 21 "other";
  ]
let suite =
  "test suite for properties"
  >::: List.flatten [ nothing_tests ]



