(* Representation of jail property data.
    This module represents the jail property data. *)
    type p
    (** The abstract type of values representing nothing boardspaces. *)
    
    type jail
    (** The abstract type that represents a nothing boardspace type  *)
    
    type property_id = int
    (** The id of property. *)

    type property_name = string
    (** The type of space name. *)

    exception UnknownProperty of property_id
    (** Raised when an unknown property is encountered. *)
    
    val from_json : Yojson.Basic.t -> p
    (** [from_json j] is the property list that [j] represents. Requires: [j] is
        a valid JSON property list representation. *)

    val properties : p -> jail list  
    (** [properties p] is the property list that [p]. *)

    val jail_id : jail -> property_id 
    (* [jail_id p] is the space id of the jail space. *)

    val name : p -> property_id -> string
    (* [name p p_id] is the space name of the jail space. *)
    
