# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Buzzword.Bingo.Player do
  @moduledoc """
  Creates a player struct for the _Multi-Player Buzzword Bingo_ game.

  The player struct contains the fields `name` and `color` representing the
  characteristics of a player in the _Multi-Player Buzzword Bingo_ game.

  ##### Based on the course [Multi-Player Bingo](https://pragmaticstudio.com/courses/unpacked-bingo) by Mike and Nicole Clark.
  """

  alias __MODULE__

  @derive [Poison.Encoder]
  @derive Jason.Encoder
  @enforce_keys [:name, :color]
  defstruct [:name, :color]

  @typedoc "Player's color"
  @type color :: String.t()
  @typedoc "Player's name"
  @type name :: String.t()
  @typedoc "A player struct for the Multi-Player Buzzword Bingo game"
  @type t :: %Player{
          name: name,
          color: color
        }

  @doc """
  Creates a player struct with the given `name` and `color`.

  ## Examples

      iex> alias Buzzword.Bingo.Player
      iex> Player.new("Helen", "#f9cedf")
      %Player{name: "Helen", color: "#f9cedf"}

      iex> alias Buzzword.Bingo.Player
      iex> Player.new("Jimmy", "deep_sky_blue")
      %Player{name: "Jimmy", color: "deep_sky_blue"}

      iex> alias Buzzword.Bingo.Player
      iex> Player.new("Jane", 'red')
      {:error, :invalid_player_args}
  """
  @spec new(name, color) :: t | {:error, atom}
  def new(name, color) when is_binary(name) and is_binary(color) do
    %Player{name: name, color: color}
  end

  def new(_name, _color), do: {:error, :invalid_player_args}

  ## Helpers

  defimpl String.Chars, for: Player do
    @spec to_string(Player.t()) :: String.t()
    def to_string(%Player{} = player), do: inspect(player)
  end
end
