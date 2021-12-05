open Yojson.Basic.Util
open Property
type property_id = int
type property_type = string
type nothing = {
  id : property_id;
  p_type : property_type; 
  color : string;
  name: string;
  price: int;
  rent: int;
}

let nothing_of_json j =
  {
    id = j |> member "property id" |> to_int;
    p_type = j |> member "property_type" |> to_string;
    color = j |> member "color" |> to_string;
    name= j |> member "name" |> to_string;
    price = j |> member "price" |> to_int;
    rent = j |> member "rent" |> to_int;
  }

type p = {
    properties : nothing list
  }
  
let nothing_list_of_json j =
    {
      properties = j |> member "property" |> to_list |> List.map nothing_of_json;
    }

let from_json json = nothing_list_of_json json 

let properties p = p.properties

let rec get_prop_by_id p_id = function
  | [] -> raise (UnknownProperty p_id)
  | h :: t -> if h.id = p_id then h else get_prop_by_id p_id t

let nothing_id prop = prop.id

let nothing_type p p_id =
  let prop = get_prop_by_id p_id p.properties in
  prop.p_type
let nothing_color p p_id =
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