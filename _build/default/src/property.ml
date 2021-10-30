open Yojson.Basic.Util
open Player

type property_type = string
type property_id = int
type color = string

exception UnknownProperty of property_id

type property = {
  id : int;
  p_type : property_type; 
  color : color;
  name: string;
  price: int;
  rent: int;
  owner : player_id option 
}

type p = {
  properties : property list 
}

(* helper functions *)
let prop_of_json j =
  {
    id = j |> member "property id" |> to_int;
    p_type = j |> member "property_type" |> to_string;
    color = j |> member "color" |> to_string;
    name= j |> member "name" |> to_string;
    price = j |> member "price" |> to_int;
    rent = j |> member "rent" |> to_int;
    owner = None
  }
let prop_list_of_json j =
  {
    properties = j |> member "properties" |> to_list |> List.map prop_of_json;
  }

let rec get_prop_by_id p_id = function
  | [] -> raise (UnknownProperty p_id)
  | h :: t -> if h.id = p_id then h else get_prop_by_id p_id t

let rec set_owner_helper p_id player_id = function
  | [] -> []
  | h :: t -> if h.id = p_id then 
    let new_prop = {h with owner = Some player_id} in 
      new_prop :: set_owner_helper p_id player_id t 
    else h :: set_owner_helper p_id player_id t 

(* end of helper functions *)
let from_json json = prop_list_of_json json 

let properties p = p.properties

let p_id prop = prop.id

let p_type p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.p_type
let color p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.color
let name p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.name
let price p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.price
let rent p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.rent
let owner p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.owner

let set_owner p p_id player_id =
  let new_properties = set_owner_helper p_id player_id p.properties 
  in {properties = new_properties}
