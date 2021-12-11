open Monopoly
open Yojson.Basic.Util
open State
open Player
open Property

(* The file store the prompts that will be displayed to the user during the game. *)

(* Setup and Initialize Prompts *)
let welcome_pmpt = "Welcome players! You each have 1500 BRBs in your GET 
account. You will each start at GO.\n"
let objective_pmpt = "Objective of the Game: Become the wealthiest player 
through buying, renting and selling property and force other players 
into bankruptcy. \n\n
Press ENTER to continue.\n"
let instructions_pmpt = "Each player starts at Go and rolls the dice and 
moves the number of spaces indicated by the two dice. Depending on the 
space the player lands on, they may buy the property, may need to pay rent, 
pay taxes, draw a Chance or Community Chest card, Go To Jail, or etc. \n\n
Press ENTER to continue.\n"
let go_pmpt = "GO: Each time a player lands on or passes over GO, the 
player gains 200 BRBs.\n"
let property_pmpt = "Buying Property : When a player lands on an unowned 
property, they can buy that property at the indicated price.\n"
let rent_pmpt = "Paying Rent : When a player lands on a property that is 
owned, they pay the owner the rent indicated for that property. \n\n
Press ENTER to continue.\n"
let chance_comm_pmpt = "Chance and Community Chest : When you land on 
either of these spaces, follow the instructions on the card.\n"
let jail_pmpt = "Jail : When you are sent to Jail, you must move directly 
into Jail and you can not collect 200 BRBs if you need to pass to Go. 
Your turn ends when you are sent to Jail. If you are not 'sent to jail' 
but pass jail, you are 'Just Visiting' and you move normally. When in jail 
you cannot buy and sell property, houses and hotels or collect rents. A 
player gets out of Jail by: Skipping two turns. \n\n
Press ENTER to continue.\n"
let parking_pmpt = "Free parking : This is a free resting place. Players 
who land on this space do not have to pay any rents or penalties. This 
space is not available for purchase.\n"
let house_hotel_pmpt = "Houses and Hotels : When a player owns all the 
properties in a color-group, they may buy houses. When a player has four 
houses on each property of the complete color group, they can buy a hotel 
for the property.\n"
let bankrupt_pmpt = "Bankruptcy : You are declared bankrupt if you owe 
more than you can pay to another player or to the bank.\n\n
Press ENTER to continue.\n"
let how_win_pmpt = "How to Win: The bankrupt players must leave the game 
and the last player left in the game is the winner. \n\n
Press ENTER to continue.\n" 

(*****************************************************************************)
(* Game Begin Prompts & Functions*)
let p = Property.from_json (Yojson.Basic.from_file "data/property_test.json")
let norm_props_lst = p |> Property.properties 

(* 1. Player lands on Unowned Property: has enough money to buy *)
(* [player] is the current player. [property] is the property they land on. *)
let game_p1 player property =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  let prop_id = Property.p_id property in
  let prop_name = Property.name p prop_id in
  let prop_cost = Property.price p prop_id |> string_of_int in
  let curr_amt = player |> get_current_amt |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on " ^ prop_name ^ ". 
  Congratulations! This property is currently unowned and you have 
  sufficient funds to make this purchase. If you so desire, you may 
  purchase this property for " ^ prop_cost ^ " BRBs. You currently 
  have " ^ curr_amt ^ ". If you would like to purchase this property, 
  press Y and ENTER. If you do not wish to purchase this property 
  press N then ENTER.
  \n\n"

(* 2. Player lands on Unowned Property: doens't have enough money to buy *)
(* [player] is the current player. [property] is the property they land on. *)
let game_p2 player property =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  let prop_id = Property.p_id property in
  let prop_name = Property.name p prop_id in
  let prop_cost = Property.price p prop_id |> string_of_int in
  let curr_amt = player |> get_current_amt |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on " ^ prop_name ^ ". 
  Oh no, you're out of luck! This property is currently unowned 
  and costs " ^ prop_cost ^ " BRBs. You only have " ^ curr_amt ^ 
  " which is not enough to make this purchase. Better luck next time! 
  Press ENTER to continue the game.
  \n\n"

(* 3. Player lands on Owned Property: has enough to pay rent *)
(* [player] is the current player. [property] is the property they land on. 
   [player_other] is the owner of the [property]. *)
let game_p3 player player_other property =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  let p_other = player_other |> Player.get_player_id |> string_of_int in
  let prop_id = Property.p_id property in
  let prop_name = Property.name p prop_id in
  let prop_rent = Property.rent p prop_id |> string_of_int in
  let curr_amt = player |> get_current_amt |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on " ^ prop_name ^ ". 
  You are out of luck! This property is currently owned by " 
  ^ p_other ^ ". Because this property is currently owned, you may 
  not purchase it. In fact, you must pay" ^ prop_rent ^ " BRBs in rent! 
  Good news, you have " ^ curr_amt ^ " which is enough funds to pay 
  rent. Press ENTER to continue the game.
  \n\n"

(* 4. Player lands on Owned Property: doesn't have enough to pay rent *)
(* [player] is the current player. [property] is the property they land on. 
   [player_other] is the owner of the [property]. *)
let game_p4 player player_other property =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  let p_other = player_other |> Player.get_player_id |> string_of_int in
  let prop_id = Property.p_id property in
  let prop_name = Property.name p prop_id in
  let prop_rent = Property.rent p prop_id |> string_of_int in
  let curr_amt = player |> get_current_amt |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on " ^ prop_name ^ ". 
  You are out of luck! This property is currently owned by " ^ p_other ^ 
  ". Because this property is currently owned, you may not purchase it. 
  In fact, you must pay" ^ prop_rent ^ " BRBs in rent! Oh no, you only 
  have " ^ curr_amt ^ " BRBs! That is not enough to cover the rent. 
  Press ENTER to continue the game.
  \n\n"

(* 5. Player lands Chance, draws a card *)
(* [player] is the current player. *)
let game_p5 player = 
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on Chance! Here at Chance, we 
  leave everything up to fate and fate alone. Will fate be on your side? 
  Will fate ruin you? Draw a card to find out. Press ENTER to continue 
  the game. May the odds be ever in you favor! 
  \n\n"

(* 6. Player lands on CC, draws a card *)
(* [player] is the current player. *)
let game_p6 player = 
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on Community Chest! Here at 
  Community Chest, we leave everything up to fate and fate alone. Will 
  fate be on your side? Will fate ruin you? Draw a card to find out. 
  Press ENTER to continue the game. May the odds be ever in you favor! 
  \n\n"

(* 7. Player lands on GO *)
let game_p7 player = 
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on GO! Congratulations for making
  a full trip around Cornell University! As a reward, please take 200 BRBs, 
  personally given to you by Martha E. Pollack herself. What an honor!
  Keep up the good work! Press ENTER to continue the game.
  \n\n"

(* 8. Player lands on Luxury Tax: has enough funds *)
let game_p8 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  let curr_amt = player |> get_current_amt |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on Luxury Tax. Martha
  has decided to increase the tuition by 100 BRBs and orders you
  to pay it right this instant. In order to avoid Martha's rath, 
  you oblige. Fortunately, you currently have " ^ curr_amt ^ " in 
  your GET account which is enough to cover it. Martha is satisifed 
  and you are now 100 BRBs poorer, but at least you didn't get 
  rescinded. Better luck next time! Press ENTER to continue the 
  game.
  \n\n"

(* 9. Player lands on Luxury Tax: doesn't have enough funds *)
let game_p9 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  let curr_amt = player |> get_current_amt |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on Luxury Tax. Martha
  has decided to increase the tuition by 100 BRBs and orders you
  to pay it right this instant. In order to avoid Martha's rath, 
  you oblige. Martha stares as you open your GET app, search for 
  your institution, and input your PIN only to see a measly " 
  ^ curr_amt ^ " in your account, which is not enough to cover your
  costs. Uh oh. Press ENTER to continue the game.
  \n\n"

(* 10. Player lands on Income Tax: has enough funds *)
let game_p10 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  let curr_amt = player |> get_current_amt |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on Income Tax. Cornell
  Dining has decided to increase the Dining Administrative Fee by 
  an outrageous 200 BRBs and orders you to pay it right this instant. 
  Sadly, you are one of the unfortunate souls stuck with the unlimited 
  meal plan so you must pay this fee if you don't want to starve to 
  death, or worse...get rescinded. Fortunately, you currently have " 
  ^ curr_amt ^ " in your GET account which is enough to cover it. 
  Cornell Dining is pleased and you are now 200 BRBs poorer, but at least 
  you didn't starve. Better luck next time! Press ENTER to continue the 
  game.
  \n\n"

(* 11. Player lands on Income Tax: doesn't have enough funds *)
let game_p11 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  let curr_amt = player |> get_current_amt |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on Income Tax. Cornell
  Dining has decided to increase the Dining Administrative Fee by 
  an outrageous 200 BRBs and orders you to pay it right this instant. 
  Sadly, you are one of the unfortunate souls stuck with the unlimited 
  meal plan so you must pay this fee if you don't want to starve to 
  death, or worse...get rescinded. Unfortunately, you spent too much 
  money at Pokelava and currently only have " ^ curr_amt ^ " in your GET 
  account which is not enough to cover your costs. Cornell Dining is 
  unhappy with you and you are now in major trouble! Uh oh. Press ENTER 
  to continue the game.
  \n\n"

(* 12. Player lands on Free Parking *)
let game_p12 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " you have landed on Free Parking. You just took
  you last final exam of the semester and feel pretty good about it. 
  Take a well deserved break. Press ENTER to continue the game.
  \n\n"

(* 13. Player lands on Go to Jail *)
let game_p13 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " you have been caught for AI violation. On a 
  fine, sunny Wednesday, you walk into 3110 lecture Uris G01 expecting to 
  chat with your friends, get some iClicker extra credit points, and maybe 
  learn some functional programming. Upon walking in, you quickly find your 
  friends and sit down. They seem to be stressed and you're not sure why. 
  You look up and realization hits as you stare at the 'Celebration of 
  Learning' plastered nice and big on the screen. You forgot about the exam. 
  Panicking, you did the only thing you could think of: you cheated. 
  Unfortunately for you, you were caught and must now go to Jail. Do not 
  collect from GO if you pass it. While in Jail you may still buy, sell, 
  trade, and collect rent from properties. There are two ways to get out 
  of Jail. You may leave Jail if you 1) have a get out of Jail free card 
  or 2) wait three turns. Press ENTER to continue the game.
  \n\n"

(* 14. Player gets out of Jail *)
let game_p14 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " you have served your time and may now leave Jail. 
  Congratulations! You may now return to regular gameplay. Make sure to be 
  a good, law abiding Cornellian and be careful to not end up in Jail 
  again! Press ENTER to continue the game.
  \n\n"

(* 15. Player goes bankrupt *)
let game_p15 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " you do not have enough funds in your GET account 
  to make ends meet. Martha has decided to rescind you and you are now out
  of the game. Better luck next time! Press ENTER to continue the game.
  \n\n"

(* NOTE: may or may not need to add more in later prompts *)
(* 16. Beginning of one player's turn *)
let game_p16 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " it is now your turn. Press ENTER to roll the die
  \n\n"

(* 17. End of one player's turn *)
let game_p17 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Player " ^ p_curr ^ " your turn has ended. Press ENTER to continue the 
  game.
  \n\n"

(* 18. Beginning of one round of turns *)
let game_p18 =
  "Beginning a new round of gameplay. Press ENTER to continue the game.
  \n\n"

(* 19. End of one round of turns *)
let game_p19 =
  "This round of gameplay is over. Press ENTER to continue the game.
  \n\n"

(* 20. End of game prompts *)
let game_p20 player =
  let p_curr = player |> Player.get_player_id |> string_of_int in
  "Congratulations to Player " ^ p_curr ^ ", you have won the game! 
  Thank you to all players for playing and Cornell Monpoly hopes to 
  see you again soon!
  \n\n"
