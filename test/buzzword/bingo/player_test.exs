defmodule Buzzword.Bingo.PlayerTest do
  use ExUnit.Case, async: true

  alias Buzzword.Bingo.Player

  doctest Player

  setup_all do
    jim = Player.new("Jim", "cyan")
    joe = Player.new("Joe", "#d3c5f1")
    jay = Player.new("Jay", "rgb(211, 97, 41)")

    encoded = %{
      jim: ~s<{"name":"Jim","color":"cyan"}>,
      joe: ~s<{"name":"Joe","color":"#d3c5f1"}>,
      jay: ~s<{"name":"Jay","color":"rgb(211, 97, 41)"}>
    }

    decoded = %{
      jim: %{"name" => "Jim", "color" => "cyan"},
      joe: %{"name" => "Joe", "color" => "#d3c5f1"},
      jay: %{"name" => "Jay", "color" => "rgb(211, 97, 41)"}
    }

    interpolated = %{
      jim: ~s|%Buzzword.Bingo.Player{name: "Jim", color: "cyan"}|,
      joe: ~s|%Buzzword.Bingo.Player{name: "Joe", color: "#d3c5f1"}|,
      jay: ~s|%Buzzword.Bingo.Player{name: "Jay", color: "rgb(211, 97, 41)"}|
    }

    %{
      players: %{jim: jim, joe: joe, jay: jay, interpolated: interpolated},
      json: %{encoded: encoded, decoded: decoded}
    }
  end

  describe "A player struct" do
    test "can be encoded by JSON", %{players: players, json: json} do
      assert JSON.encode!(players.jim) == json.encoded.jim
      assert JSON.decode!(json.encoded.jim) == json.decoded.jim

      assert JSON.encode!(players.joe) == json.encoded.joe
      assert JSON.decode!(json.encoded.joe) == json.decoded.joe

      assert JSON.encode!(players.jay) == json.encoded.jay
      assert JSON.decode!(json.encoded.jay) == json.decoded.jay
    end

    test "supports string interpolation", %{players: players} do
      assert "#{players.jim}" == players.interpolated.jim
      assert "#{players.joe}" == players.interpolated.joe
      assert "#{players.jay}" == players.interpolated.jay
    end
  end

  describe "Player.new/2" do
    test "returns a player struct" do
      assert Player.new("Joe", "blue") == %Player{name: "Joe", color: "blue"}
    end

    test "returns a player struct in a `with` macro" do
      assert(
        with %Player{} = player <- Player.new("Joe", "blue") do
          player
        end == %Player{name: "Joe", color: "blue"}
      )
    end

    test "returns an error tuple" do
      assert Player.new("Jim", :red) == {:error, :invalid_player_args}
    end

    test "returns an error tuple in a 'with' macro" do
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
