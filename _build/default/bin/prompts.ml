(* The file store the prompts that will be displayed to the user during the game. *)

(* Setup Stage Prompts *)
let welcome_pmpt = "Welcome players! You each have 1500 BRBs in your GET account. 
  You will each start at GO.\n"
let objective_pmpt = "Objective of the Game: Become the wealthiest player through 
  buying, renting and selling property and force other players into bankruptcy. 
  Press ENTER to continue."
let instructions_pmpt = "Each player starts at Go and rolls the dice and moves the 
  number of spaces indicated by the two dice. Depending on the space the player 
  lands on, they may buy the property, may need to pay rent, pay taxes, draw a 
  Chance or Community Chest card, Go To Jail, or etc. Press ENTER to continue."
let go_pmpt = "GO: Each time a player lands on or passes over GO, the player gains 
  200 BRBs.\n"
let property_pmpt = "Buying Property : When a player lands on an unowned property, 
  they can buy that property at the indicated price.\n"
let rent_pmpt = "Paying Rent : When a player lands on a property that is owned, they pay 
  the owner the rent indicated for that property. Press ENTER to continue."
let chance_comm_pmpt = "Chance and Community Chest : When you land on either of these 
  spaces, follow the instructions on the card.\n"
let jail_pmpt = "Jail : When you are sent to Jail, you must move directly into Jail 
  and you can not collect 200 BRBs if you need to pass to Go. Your turn ends when 
  you are sent to Jail. If you are not 'sent to jail' but pass jail, you are 'Just 
  Visiting' and you move normally. When in jail you cannot buy and sell property, 
  houses and hotels or collect rents. A player gets out of Jail by: Skipping two 
  turns. Press ENTER to continue."
let parking_pmpt = "Free parking : This is a free resting place, so that the 
  players landing on it don’t have to pay any rents or penalties.\n"
let house_hotel_pmpt = "Houses and Hotels : When a player owns all the properties in 
  a color-group, they may buy houses. When a player has four houses on each property 
  of the complete color group, they can buy a hotel for the property.\n"
let bankrupt_pmpt = "Bankruptcy : You are declared bankrupt if you owe more than 
  you can pay to another player or to the bank.Press ENTER to continue."
let how_win_pmpt = "How to Win: The bankrupt players must leave the game and the 
  last player left in the game is the winner. Press ENTER to continue." 