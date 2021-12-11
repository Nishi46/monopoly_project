open OUnit2
open Yojson.Basic.Util
open Monopoly
open Property
open Player 
open State

let init_state_test_players
(name : string)
(num_players: int)
(expected_output : int) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (State.init_state' num_players |> State.player_list |> List.length )

let init_state_test_boardspaces
(name : string)
(num_players: int)
(expected_output : int) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (State.init_state' num_players |> State.board_spaces |> List.length )

let init_state_test_jailed_players
(name : string)
(num_players: int)
(expected_output : int) : test =
name >:: fun _ -> 
assert_equal ~printer: string_of_int
expected_output (State.init_state' num_players |> State.jailed_player_ids |> List.length )

let init_state_test_status
(name : string)
(num_players: int)
(expected_output : string) : test =
name >:: fun _ -> 
assert_equal 
expected_output (State.init_state' num_players |> State.status )

let init_state_test_current_player
(name : string)
(num_players: int)
(expected_output : int) : test =
name >:: fun _ -> 
assert_equal 
expected_output (State.init_state' num_players |> State.current_player_id )

let check_bankcrupty_test
(name : string)
(t : State.t)
(expected_output : State.t) : test =
name >:: fun _ -> 
assert_equal 
expected_output (State.check_bankruptcy t)


let pass_go_test
(name : string)
(t : State.t)
(expected_output : State.t) : test =
name >:: fun _ -> 
assert_equal 
expected_output (State.pass_go t)

let init_state = State.init_state' 3
let state_tests = 
  [
    init_state_test_players "init state, 3 players" 3 3;
    init_state_test_players "init state, 3 players" 5 5;
    init_state_test_boardspaces "init state, boardspaces" 5 40;
    init_state_test_status "init state, status" 5 "start";
    init_state_test_current_player "init state, current player" 5 0;
    init_state_test_jailed_players "init state, current player" 5 0;
    check_bankcrupty_test "check bankruptcy init state" init_state init_state;
  ]
let suite =
  "test suite for properties"
  >::: List.flatten [ state_tests ]
