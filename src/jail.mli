(* Representation of property data.
    This module represents the property data. *)
    type p
    (** The abstract type of values representing nothing boardspaces. *)
    
    type jail
    (** The abstract type that represents a nothing boardspace type  *)
    
    type property_type = string
    (** The type of property. *)
    
    type property_id = int
    (** The id of property. *)
    
    val from_json : Yojson.Basic.t -> p
    (** [from_json j] is the property list that [j] represents. Requires: [j] is
        a valid JSON property list representation. *)

    val properties : p -> jail list  
    (** [p_id property] is the id of property [property]. *)
        
    
    val jail_id : jail -> property_id 
    (** [p_id property] is the id of property [property]. *)
    
    val jail_type : p -> property_id -> property_type 
    (** [p_id p p_id] is the property_type of property with id [p_id]. *)
    
    val jail_color : p -> property_id -> string
    (** [p_id p p_id] is the color of property with id [p_id]. *)
    
    val jail_name : p -> property_id -> string 
    (** [p_id p p_id] is the name of property with id [p_id]. *)
    
    val price : p -> property_id -> int 
    (** [p_id p p_id] is the price of property with id [p_id]. *)
    
    val rent : p -> property_id -> int 
    (** [p_id p p_id] is the rent of property with id [p_id]. *)
    
