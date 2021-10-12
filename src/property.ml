
type p_type = string
type color = string


type property = { 
  p_type : p_type; 
  color : color;
  name: string;
  price: int;
  rent: int;
  owner : string (* change to optional player *)
}

let p_type p = p.p_type
let color p = p.color
let name p = p.name
let price p = p.price
let rent p = p.rent 
let owner p = p.owner 
let set_owner p o = {p with owner = o}