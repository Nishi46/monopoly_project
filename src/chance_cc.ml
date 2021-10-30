type property_id = int

type property_name = string

type chance_cc_space = {
  property_id : property_id;
  property_name : property_name
}

let id c = c.property_id

let name c = c.property_name

let is_chance c = c.property_name = "Chance"

let is_cc c = c.property_name = "Community Chest"
