(* Representation of nothing property data.
    This module represents the nothing property data. *)
    type p
    (** The abstract type of values representing nothing spaces. *)
    
    type nothing
    (** The abstract type that represents a single nothing boardspace.  *)
    
    type property_id = int
    (** The id of property. *)

    type property_name = string
    (** The name of the property. *)

    exception UnknownProperty of property_id
    (** Raised when an unknown property is encountered. *)

    val from_json : Yojson.Basic.t -> p
    (** [from_json j] is the nothing property list that [j] represents. 
    Requires: [j] is a valid JSON property list representation. *)

    val properties : p -> nothing list 
    (** [properties p] is list of properties in p. *)

    val nothing_id : nothing -> property_id 
    (** [p_id property] is the id of property [property]. *)

    val name : p -> property_id -> string 
    (** [p_id p p_id] is the name of property with id [p_id]. *)