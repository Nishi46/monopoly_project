open Property
type nothing = property list

let nothing_of_json j =
  {
    id = j |> member "property id" |> to_int;
    p_type = j |> member "property_type" |> to_string;
    color = j |> member "color" |> to_string;
    name= j |> member "name" |> to_string;
    price = j |> member "price" |> to_int;
    rent = j |> member "rent" |> to_int;
    owner = None
  }
  
type p = {
    properties : property list 
  }
  
let nothing_list_of_json j =
    {
      properties = j |> member "properties" |> to_list |> List.map prop_of_json;
    }