(* update players’ funds as they play - increase when others pay rent,
 decrease when they land on others’ property, decrease when they 
 purchase property etc.  *)
open Player
open Property

<<<<<<< HEAD
(* let pay_rent_helper rent_payer rent_taker rent = 
=======
let pay_rent_helper rent_payer rent_taker rent = 
>>>>>>> b9f0f2ac09458f7ea07e3be9b514496bfe7cfcb7
  rent_payer.current_amount = rent_payer.current_amount - rent
  rent_taker.current_amount = rent_taker.current_amount + rent

let pay_rent property player =
  let property_rent = property.rent in
  let player_pay_rent = if property.owner = None then (**option to buy property*)
  else pay_rent_helper player property.owner property_rent
let purchase_property property player =
    if property.owner = None then if property.price > player.current_amount then 
    property.owner = player.id else
<<<<<<< HEAD
    pay_rent property player *)
=======
    pay_rent property player
>>>>>>> b9f0f2ac09458f7ea07e3be9b514496bfe7cfcb7
