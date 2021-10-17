(* Representation of property data.
    This module represents the property data. *)

type property
(** The abstract type that represents a property *)

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