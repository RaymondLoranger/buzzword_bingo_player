defmodule Buzzword.Bingo.PlayerTest do
  use ExUnit.Case, async: true

  alias Buzzword.Bingo.Player

  doctest Player

  setup_all do
    jim = Player.new("Jim", "cyan")
    joe = Player.new("Joe", "#d3c5f1")
    jay = Player.new("Jay", "rgb(211, 197, 241)")

    poison = %{
      jim: ~s<{"name":"Jim","color":"cyan"}>,
      joe: ~s<{"name":"Joe","color":"#d3c5f1"}>,
      jay: ~s<{"name":"Jay","color":"rgb(211, 197, 241)"}>
    }

    jason = %{
      jim: ~s<{"color":"cyan","name":"Jim"}>,
      joe: ~s<{"color":"#d3c5f1","name":"Joe"}>,
      jay: ~s<{"color":"rgb(211, 197, 241)","name":"Jay"}>
    }

    decoded = %{
      jim: %{"name" => "Jim", "color" => "cyan"},
      joe: %{"name" => "Joe", "color" => "#d3c5f1"},
      jay: %{"name" => "Jay", "color" => "rgb(211, 197, 241)"}
    }

    interpolated = %{
      jim: ~s|%Buzzword.Bingo.Player{color: "cyan", name: "Jim"}|,
      joe: ~s|%Buzzword.Bingo.Player{color: "#d3c5f1", name: "Joe"}|,
      jay: ~s|%Buzzword.Bingo.Player{color: "rgb(211, 197, 241)", name: "Jay"}|
    }

    %{
      players: %{jim: jim, joe: joe, jay: jay, interpolated: interpolated},
      json: %{poison: poison, jason: jason, decoded: decoded}
    }
  end

  describe "A player struct" do
    test "can be encoded by Poison", %{players: players, json: json} do
      assert Poison.encode!(players.jim) == json.poison.jim
      assert Poison.decode!(json.poison.jim) == json.decoded.jim

      assert Poison.encode!(players.joe) == json.poison.joe
      assert Poison.decode!(json.poison.joe) == json.decoded.joe

      assert Poison.encode!(players.jay) == json.poison.jay
      assert Poison.decode!(json.poison.jay) == json.decoded.jay
    end

    test "can be encoded by Jason", %{players: players, json: json} do
      assert Jason.encode!(players.jim) == json.jason.jim
      assert Jason.decode!(json.jason.jim) == json.decoded.jim

      assert Jason.encode!(players.joe) == json.jason.joe
      assert Jason.decode!(json.jason.joe) == json.decoded.joe

      assert Jason.encode!(players.jay) == json.jason.jay
      assert Jason.decode!(json.jason.jay) == json.decoded.jay
    end

    test "supports string interpolation", %{players: players} do
      assert "#{players.jim}" == players.interpolated.jim
      assert "#{players.joe}" == players.interpolated.joe
      assert "#{players.jay}" == players.interpolated.jay
    end
  end

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

    test "returns a tuple in a 'with' macro" do
      assert(
        with %Player{} = player <- Player.new("Jim", :red) do
          player
        else
          error -> error
        end == {:error, :invalid_player_args}
      )
    end
  end
end
