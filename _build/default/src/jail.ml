(** Jail module *)
open Property
open Yojson.Basic.Util
type property_id = int

type property_type = string

type jail = {
  id : property_id;
  property_type : property_type; 
  color : string;
  name: string;
  price: int;
  rent: int;
}
let jail_of_json j =
  {
    id = j |> member "property id" |> to_int;
    property_type = j |> member "property_type" |> to_string;
    color = j |> member "color" |> to_string;
    name= j |> member "name" |> to_string;
    price = j |> member "price" |> to_int;
    rent = j |> member "rent" |> to_int;
  }

  type p = {
    properties : jail list
  }
  
let jail_list_of_json j =
    {
      properties = j |> member "property" |> to_list |> List.map jail_of_json;
    }

let from_json json = jail_list_of_json json 

let properties p = p.properties

let rec get_prop_by_id p_id = function
  | [] -> raise (UnknownProperty p_id)
  | h :: t -> if h.id = p_id then h else get_prop_by_id p_id t

let jail_id prop = prop.id

let jail_type p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.property_type
let jail_color p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.color
let jail_name p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.name
let price p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.price
let rent p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.rent