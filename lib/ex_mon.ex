defmodule ExMon do
  alias ExMon.Player

  def create_player(name, move_rnd, move_arg, move_heal) do
    Player.build(name, move_rnd, move_arg, move_heal)
  end
end
