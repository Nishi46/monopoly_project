(* Representation of chance and community chest space data.
    This module represents the chance and community chest space data. *)

    type chance_cc_space
    (* The abstract type that represents a chance or community chest space on the board.*)
    
    type property_id = int
    (* The type of space id.*)
    
    type property_name = string
    (* The type of space name. *)
    
    val id : chance_cc_space -> property_id
    (* [id c] is the space id of the chance or community chest space. *)
    
    val name : chance_cc_space -> property_name
    (* [name c] is the space name of the chance or community chest space. *)
    
    val is_chance : chance_cc_space -> bool
    (* [is_chance c] returns whether or not the space is a chance space. *)
    
    val is_cc : chance_cc_space -> bool
    (* [is_cc c] returns whether or not the space is a commmunity chest space. *)
    