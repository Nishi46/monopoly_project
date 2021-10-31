open Player
open Property 
open Boardspace

type t = 
{
  status : string;
  players : player list;
  board_spaces : board_space list;
  current_player : player; 
  jailed_player_ids : player_id list; 

}