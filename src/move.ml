open State
open Cards
open Player
      
let take_tax p pos =
  if pos = 5 then Player.deduct_amt p 200
  else if pos = 39 then Player.deduct_amt p 100
  else p

let change_player_list idx new_player players =
  let rec aux n lst acc =
    match lst with
    | [] -> acc
    | h :: t ->
        if n = idx then aux (n + 1) t (new_player :: acc)
        else aux (n + 1) t (h :: acc)
  in
  aux 0 players []

let roll_dice s i =
  let players = player_list s in
  let player = List.nth players i in
  let dice1 = Random.int 5 + 1 in
  let dice2 = Random.int 5 + 1 in
  let sum = dice1 + dice2 in
  (*let () = print_endline (string_of_int dice1 ^ " " ^ string_of_int dice2) in*)
  let new_pos = (Player.get_current_location player + dice1 + dice2) mod 40 in
  if new_pos = 1 then pass_go s
  else
    let taxed_player = take_tax player new_pos in
    let deck =
      Cards.chance_cc_of_json (Yojson.Basic.from_file "data/cards.json")
    in
    let c =
      Chancecc.from_json
        (Yojson.Basic.from_file "data/chance_community_chest.json")
    in
    if Chancecc.is_cc c new_pos then Cards.draw_cc deck s
    else if Chancecc.is_chance c new_pos then draw_chance deck s
    else
      let p =
        Property.from_json (Yojson.Basic.from_file "data/property_test.json")
      in
      let rented = Property.owner p new_pos in
      (*let prop = (prop p new_pos) in*)
      let rent_p = Property.rent p new_pos in
      let function1 b = match b with None -> 0 | Some int -> int in
      let owner = function1 rented in
      let owner_prop = get_player_by_id owner players in
      if rented != Some i then
        let rent_player = increment_amt owner_prop rent_p in
        let rented_player = deduct_amt player rent_p in
        let new_player = Player.move_player rent_player sum in
        let new_lst = List.rev (change_player_list i new_player players) in
        let new_lst' =
          List.rev
            (change_player_list (get_player_id player) rented_player new_lst)
        in
        State.set_player_list s new_lst'
      else
        let new_player = Player.move_player taxed_player sum in
        let new_lst = List.rev (change_player_list i new_player players) in
        State.set_player_list s new_lst
