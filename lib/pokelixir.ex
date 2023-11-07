defmodule Pokelixir do
  @moduledoc """
  Documentation for `Pokelixir`.
  """

  @doc """

  ## Examples

  """
  def get(pokemon_name) do
    base_url = "https://pokeapi.co/api/v2/pokemon"
    method = :get
    fetched_pokemon = Finch.build(method, "#{base_url}/#{pokemon_name}") |> Finch.request!(MyFinch)
    decoded = Jason.decode!(fetched_pokemon.body)
    %Pokemon{id: decoded.id, name: decoded.name,
      hp:, attack:, defence:, special_attack:, special_defence:, speed:,
      height: decoded.height, weight: decoded.weight, types:}
  end
  def all() do
    all_pokemon = []
    
  end
  def parse_stats(stats) do
  end
  def parse_types(types) do
  end
end
