open Yojson.Basic.Util

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
