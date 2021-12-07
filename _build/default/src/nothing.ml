open Yojson.Basic.Util

type property_id = int
type property_name = string

exception UnknownProperty of property_id

type nothing = {
  property_id : property_id;
  property_name : property_name
}

type p = {
    properties : nothing list
  }

(* helper functions *)
let nothing_of_json j =
  {
    property_id = j |> member "property_id" |> to_int;
    property_name = j |> member "property_name" |> to_string
  }
  
let nothing_list_of_json j =
    {
      properties = j |> member "property" |> to_list |> List.map nothing_of_json;
    }

let from_json json = nothing_list_of_json json 

let properties p = p.properties

let rec get_prop_by_id p_id = function
  | [] -> raise (UnknownProperty p_id)
  | h :: t -> if h.property_id = p_id then h else get_prop_by_id p_id t

let properties s = s.properties

(* end of helper functions*)

let from_json json = nothing_list_of_json json

let nothing_id prop = prop.property_id

let name p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.property_name