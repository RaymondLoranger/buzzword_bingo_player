defmodule Buzzword.Bingo.PlayerTest do
  use ExUnit.Case, async: true

  alias Buzzword.Bingo.Player

  doctest Player

  describe "Player.new/2" do
    test "returns a struct" do
      assert Player.new("Joe", "blue") == %Player{name: "Joe", color: "blue"}
    end

    test "returns a struct in a `with` macro" do
      assert(
        with %Player{} = player <- Player.new("Joe", "blue") do
          player
        end == %Player{name: "Joe", color: "blue"}
      )
    end

    test "returns a tuple" do
      assert Player.new("Jim", :red) == {:error, :invalid_player_args}
    end

    test "returns a tuple in a `with` macro" do
      assert(
        with %Player{} = player <- Player.new("Jim", :red) do
          player
        else
          error -> error
        end == {:error, :invalid_player_args}
      )
    end

    test "can be encoded by Poison" do
      jim = Player.new("Jim", "cyan")
      assert Poison.encode!(jim) == ~s<{"name":"Jim","color":"cyan"}>
    end

    test "can be encoded by Jason" do
      jim = Player.new("Jim", "cyan")
      assert Jason.encode!(jim) == ~s<{"color":"cyan","name":"Jim"}>
    end
  end
end
