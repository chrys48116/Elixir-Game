defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "Start the game state" do
      player = Player.build("chrystian", :punch, :kick, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "return the current game state" do
      player = Player.build("chrystian", :punch, :kick, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      Game.start(computer, player)

      expected_response = %{status: :started, player: %Player{life: 100, name: "chrystian", moves: %{move_heal: :heal, move_rnd: :punch, move_avg: :kick}}, computer: %Player{life: 100, name: "Robotinik", moves: %{move_heal: :heal, move_rnd: :punch, move_avg: :kick}}, turn: :player}

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "return the game state update" do
      expected_response = %{status: :started, player: %Player{life: 100, name: "chrystian", moves: %{move_heal: :heal, move_rnd: :punch, move_avg: :kick}}, computer: %Player{life: 100, name: "Robotinik", moves: %{move_heal: :heal, move_rnd: :punch, move_avg: :kick}}, turn: :player}

      assert expected_response == Game.info()

      new_state = %{status: :started, player: %Player{life: 85, name: "chrystian", moves: %{move_heal: :heal, move_rnd: :punch, move_avg: :kick}}, computer: %Player{life: 50, name: "Robotinik", moves: %{move_heal: :heal, move_rnd: :punch, move_avg: :kick}}, turn: :player}

      Game.update(new_state)

      expected_response = %{new_state | status: :continue, turn: :computer}
      assert expected_response == Game.info()
    end
  end
end
