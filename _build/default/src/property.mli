(* Representation of property data.
    This module represents the property data. *)
type p
(** The abstract type of values representing properties. *)

type property
(** The abstract type that represents a property *)

type property_type = string
(** The type of property. *)

type property_id = int
(** The id of property. *)

type color = string
(** The type of property color. *)

exception UnknownProperty of property_id
(** Raised when an unknown property is encountered. *)

val from_json : Yojson.Basic.t -> p
(** [from_json j] is the property list that [j] represents. Requires: [j] is
    a valid JSON property list representation. *)

val make_p : property list -> p
(** [make_p prop] is p with property list [prop] *)

val properties : p -> property list 
(** [properties p] is the property list that [p] contains *)

val prop : p -> property_id -> property
(** [prop p p_id] is the property with id [p_id]. *)

val p_id : property -> property_id 
(** [p_id property] is the id of property [property]. *)

val p_type : p -> property_id -> property_type 
(** [p_id p p_id] is the property_type of property with id [p_id]. *)

val color : p -> property_id -> color 
(** [p_id p p_id] is the color of property with id [p_id]. *)

val name : p -> property_id -> string 
(** [p_id p p_id] is the name of property with id [p_id]. *)

val price : p -> property_id -> int 
(** [p_id p p_id] is the price of property with id [p_id]. *)

val rent : p -> property_id -> int 
(** [p_id p p_id] is the rent of property with id [p_id]. *)

val owner : p -> property_id -> int option
(** [p_id p p_id] is the player id who owns the property with id [p_id]. *)

val set_owner : p -> property_id -> int option -> property 
(** [set_owner p p_id, player_id] is p where property with 
id [p_id] is updated with owner whose id is [player_id] *)