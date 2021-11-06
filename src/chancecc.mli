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
(** [name c p_id] is the space name of the chance or community chest space. *)

val is_chance : c -> property_id -> bool
(** [is_chance c p_id] returns whether or not the space with the is a chance 
    corresponding [p_id] is a chance space. *)

val is_cc : c -> property_id -> bool
(** [is_cc c p_id] returns whether or not the space with the is a chance 
    corresponding [p_id] is a community chest space. *)