(** Jail module *)
open Property
open Yojson.Basic.Util

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

