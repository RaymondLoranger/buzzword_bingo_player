# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Buzzword.Bingo.Player do
  use PersistConfig

  @course_ref Application.get_env(@app, :course_ref)

  @moduledoc """
  Creates a `player` struct for the _Multi-Player Bingo_ game.
  \n##### #{@course_ref}
  """

  alias __MODULE__

  @derive [Poison.Encoder]
  @derive Jason.Encoder
  @enforce_keys [:name, :color]
  defstruct [:name, :color]

  @type t :: %Player{
          name: String.t(),
          color: String.t()
        }

  @doc """
  Creates a `player` with the given `name` and `color`.

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
  @spec new(String.t(), String.t()) :: t | {:error, atom}
  def new(name, color) when is_binary(name) and is_binary(color) do
    %Player{name: name, color: color}
  end

  def new(_name, _color), do: {:error, :invalid_player_args}
end
