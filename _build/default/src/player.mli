(* Representation of player data.
    This module represents the player data. *)
    type player
    (* The abstract type that represents a player. *)
    
    type player_id = int
    (* The type of player's id. *)
    
    exception InvalidPlayerNumber
    (* exception that is thrown when an invalid player number is provided. *)
    
    type amount = int
    (* The type of the amount that each player has. *)
    
    val player_records_list : string -> player list
    (* [player_records_list number] is list of [no_of_players] player types, each 
       player with a distinct id between 1-4. *)
    
    val get_current_location : player -> int
    (** [get_current_location player] returns the current location
     of the player on the board. *)
    
    val get_player_id : player -> player_id
    (* [get_player_id player] returns the player id
     of the selected player. *)
    
    val get_all_properties : player -> int list
    (* [get_all_properties player] returns all the properties that the player 
    owns*)
    
    val get_player_by_id : player_id -> player list -> player
    (* [get_player_by_id id lst] returns the player with a corresponding id inside
    of a player list. *)

    val get_others_by_id : player_id -> player list -> player list
    (* [get_player_by_id id lst] returns the a list of all players except the player
     with a corresponding id inside of a player list. *)

    val get_current_amt : player -> amount
    (* [get_current_amt] returns the current amount that the player
     has in their game current account *)

    val deduct_amt : player -> amount -> player
      (* [deduct_amt] performs deductions of the input amount on the 
      current amount of the player input *)

    val increment_amt : player -> amount -> player
      (* [increment_amt] performs incrementations of the input amount on the 
      current amount of the player input *)
    
    val pay_rent_helper : player -> player -> amount -> player list
   (* [pay_rent_helper] increments current account balance of the rent taker (player) and 
    decrements current account balance of the rent payer (player)
    with the given input amount *)
    
    val collect_money_from_bank : player -> amount -> player
   (* [collect_money_from_bank] increments the player's current account balance 
   by input amount *)

    val pay_all : player -> player list -> amount -> player list
   (* [pay_all plist player amt] has the [player] pay all of the other players 
    in [plist] the specified [amt]. Returns a full player list with all players. *)

    val collect_all : player -> player list -> amount -> player list
   (* [collect_all plist player amt] has the [player] collect from all of the other 
    players in [plist] the specified [amt]. Returns a full player list with all players. *)
    
    val check_bankcrupty : player -> bool
   (* [check_bankcrupty] returns whether the player is bankcrupt or not (player's 
   current account is less than 0 or not) *)
    
    val change_location : player -> int -> player
   (* [change_location] changes the player's current_location field to the
   property_id innputted *)

   val move_player : player -> int -> player 
   (* [move_player] changes the player's current_location based on the number of moves
   and 40 boardspaces *)

   val properties : player -> int list 
(* [properties p] are the properties p owns *)

val remove_property: player -> int -> player 
(* [remove_property p p_id] is p with p_id removed from the properties of p *)

val add_property: player -> int -> player 
(* [add_property p p_id] is p with p_id added to the properties of p *)