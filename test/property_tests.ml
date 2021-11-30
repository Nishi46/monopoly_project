open OUnit2
open Yojson.Basic.Util
open Monopoly
open Property

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
    (expected_output : Property.p) : test = 
  name >:: fun _ -> assert_equal expected_output (Property.from_json json)

let properties_test
(name : string)
(p : Property.p)
(expected_output : Property.property list) : test =
name >:: fun _ ->
assert_equal ~cmp:cmp_set_like_lists 
expected_output (Property.properties p)

let property_id_test
(name : string)
(p : Property.p)
(prop : Property.property)
(expected_output : Property.property_id) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (Property.p_id prop)

let property_type_test
(name : string)
(p : Property.p)
(prop_id : Property.property_id)
(expected_output : Property.property_type) : test =
name >:: fun _ -> 
assert_equal ~printer: (fun x -> x)
expected_output (Property.p_type p prop_id)

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
expected_output (Property.owner p prop_id)
let p = Property.from_json (Yojson.Basic.from_file "data/property_test.json")
let p_set_owner1 = Property.set_owner p 2 5
let p_set_owner2 = Property.set_owner p 4 1
let property_tests = [

  property_id_test "test head of list" p (p |> Property.properties |> List.hd) 2;
  property_id_test "test tail of list" p (p |> Property.properties |> List.rev |> List.hd) 4;
  property_type_test "test property type" p 2 "normal";
  property_type_test "test property type" p 4 "normal";
  property_color_test "test color" p 2 "brown";
  property_color_test "test color" p 4 "brown";
  property_name_test "test name" p 2 "Flora Rose House";
  property_name_test "test name" p 4 "Alice Cook House";
  property_price_test "test price" p 2 60;
  property_price_test "test price" p 4 60;
  property_rent_test "test rent" p 2 4;
  property_rent_test "test rent" p 4 4;
  property_owner_test "test owner" p 2 None;
  property_owner_test "test owner2" p 4 None;

  property_owner_test "test set owner" p_set_owner1 2 (Some 5);
  property_owner_test "test set owner" p_set_owner2 4 (Some 1);

  ]
let suite =
  "test suite for properties"
  >::: List.flatten [ property_tests ]



