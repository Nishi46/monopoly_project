(* Representation of chance and community chest space data.
    This module represents the chance and community chest space data. *)

type c 
(** The abstract types representing the chance and community chest spaces. *)

type chance_cc_space
(** The abstract type that represents a single chance or community chest 
    space on the board.*)

type property_id = int
(** The type of space id.*)

type property_name = string
(** The type of space name. *)

exception UnknownProperty of property_id
(** Raised when an unknown property is encountered. *)

val from_json : Yojson.Basic.t -> c
(** [from_json j] is the property list that [j] represents. Requires: [j] is
    a valid JSON property list representation. *)

val properties : c -> chance_cc_space list 
(** [properties s] is the chance and cc list that [c] contains *)

val id : chance_cc_space -> property_id
(** [id s] is the space id of the chance or community chest space. *)

val name : c -> property_id -> string
(** [name s p_id] is the space name of the chance or community chest space. *)

val is_chance : chance_cc_space -> bool
(** [is_chance s] returns whether or not the space is a chance space. *)

val is_cc : chance_cc_space -> bool
(** [is_cc s] returns whether or not the space is a commmunity chest space. *)
    