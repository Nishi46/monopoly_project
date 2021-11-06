(* Representation of luxury tax, income teax, and go space data.
    This module represents the chance and community chest space data. *)

type special
(** The abstract types representing luxury tax, income tax, and go spaces. *)

type special_space 
(** The abstract type that represents a single luxury tax, income tax, or go 
   space on the board. *)

type property_id = int
(** The type of space id.*)

type property_name = string
(** The type of space name. *)

exception UnknownProperty of property_id
(** Raised when an unknown property is encountered. *)

val from_json : Yojson.Basic.t -> special
(** [from_json j] is the property list that [j] represents. Requires: [j] is
a valid JSON property list representation. *)

val properties : special -> special_space list 
(** [properties p] is the property list that [p] contains *)

val id : special_space -> property_id
(* [id s] is the space id of the chance or community chest space. *)

val name : special -> property_id -> string
(* [name s p_id] is the space name of the chance or community chest space. *)
  