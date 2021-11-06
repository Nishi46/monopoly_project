open Yojson.Basic.Util

type property_id = int
type property_name = string

exception UnknownProperty of property_id

type special_space = {
  property_id : property_id;
  property_name : property_name
}

type special = {
  special_spaces : special_space list
}

(* helper functions *)
let prop_of_json j = 
  {
    property_id = j |> member "property_id" |> to_int;
    property_name = j |> member "property_name" |> to_string
  }

let prop_list_of_json j =
  {
    special_spaces = j |> member "property" |> to_list |> List.map prop_of_json;
  }

  let rec get_prop_by_id p_id = function
  | [] -> raise (UnknownProperty p_id)
  | h :: t -> if h.property_id = p_id then h else get_prop_by_id p_id t

let properties s = s.special_spaces

(* end of helper functions*)
let from_json json = prop_list_of_json json

let id s = s.property_id

let name s p_id = 
  let prop = get_prop_by_id p_id s.special_spaces in
  prop.property_name