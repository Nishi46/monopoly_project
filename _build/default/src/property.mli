(* Representation of property data.
    This module represents the property data. *)
<<<<<<< HEAD
type p
(** The abstract type of values representing properties. *)
=======
>>>>>>> b9f0f2ac09458f7ea07e3be9b514496bfe7cfcb7

type property
(** The abstract type that represents a property *)

<<<<<<< HEAD
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

val properties : p -> property list 
(** [properties p] is the property list that [p] contains *)

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

val set_owner : p -> property_id -> int -> p 
(** [set_owner p p_id, player_id] is p where property with 
id [p_id] is updated with owner whose id is [player_id] *)
=======
type p_type = string
(** The type of property. *)

type color = string
(** The type of property color. *)

val p_type : property -> p_type 
(** [p_type p] is the property type of property [p]. *)

val color : property -> color 
(** [color p] is the color of property [p]. *)

val name : property -> string
(** [name p] is the name of property [p]. *)

val price : property -> int 
(** [price p] is the price of property [p]. *)

val rent : property -> int 
(** [rent p] is the rent of property [p]. *)

val owner : property -> string 
(** [owner p] is the owner of property [p]. *)

val set_owner : property -> string -> property
(** [set_owner p o] is the property [p] with owner o. *)
>>>>>>> b9f0f2ac09458f7ea07e3be9b514496bfe7cfcb7
