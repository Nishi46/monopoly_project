open Yojson.Basic.Util

type property_id = int
type property_name = string

exception UnknownProperty of property_id

type jail = {
  property_id : property_id;
  property_name : property_name
}

type p = {
  properties : jail list
}

(* helper functions *)
let jail_of_json j =
  {
    property_id = j |> member "property_id" |> to_int;
    property_name = j |> member "property_name" |> to_string
  }

let jail_list_of_json j =
  {
    properties = j |> member "property" |> to_list |> List.map jail_of_json;
  }

let rec get_prop_by_id p_id = function
  | [] -> raise (UnknownProperty p_id)
  | h :: t -> if h.property_id = p_id then h else get_prop_by_id p_id t

let from_json json = jail_list_of_json json 

let properties p = p.properties

(* end of helper functions*)

let from_json json = jail_list_of_json json

let jail_id s = s.property_id

let name s p_id = 
  let prop = get_prop_by_id p_id s.properties in
  prop.property_name