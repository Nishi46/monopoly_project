open Player
open Property 

type t = 
{
  status : string;
  players : player list;
  properties : property list;
  current_player : player; 
  jailed_player_ids : player_id list; 
  
}