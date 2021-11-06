open Yojson.Basic.Util

type property_id = int
type property_name = string

exception UnknownProperty of property_id

type chance_cc_space = {
  property_id : property_id;
  property_name : property_name
}

type c = {
  chance_cc_spaces : chance_cc_space list
}

(* helper functions *)
let prop_of_json j = 
  {
    property_id = j |> member "property_id" |> to_int;
    property_name = j |> member "property_name" |> to_string
  }

let prop_list_of_json j =
  {
    chance_cc_spaces = j |> member "property" |> to_list |> List.map prop_of_json;
  }

  let rec get_prop_by_id p_id = function
  | [] -> raise (UnknownProperty p_id)
  | h :: t -> if h.property_id = p_id then h else get_prop_by_id p_id t

let properties c = c.chance_cc_spaces

(* end of helper functions*)
let from_json json = prop_list_of_json json

let id s = s.property_id

let name c p_id = 
  let prop = get_prop_by_id p_id c.chance_cc_spaces in
  prop.property_name

let is_chance c p_id = 
  let prop = get_prop_by_id p_id c.chance_cc_spaces in
  prop.property_name = "Chance"

let is_cc c p_id = 
  let prop = get_prop_by_id p_id c.chance_cc_spaces in
  prop.property_name = "Community Chest"
