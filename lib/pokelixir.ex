defmodule Pokelixir do
  @moduledoc """
  Documentation for `Pokelixir`.
  fetches data of pokemon from PokeApi(https://pokeapi.co/api/v2/)"
  """

  @doc """
  user provides name of pokemon, returns various stats and attributes as a Pokemon struct.
  

  """
  def get(pokemon_name) do
    IO.puts("fetching data for #{pokemon_name}")
    base_url = "https://pokeapi.co/api/v2/pokemon"
    method = :get
    fetched_pokemon = Finch.build(method, "#{base_url}/#{pokemon_name}") |> Finch.request!(MyFinch)
    decoded = Jason.decode!(fetched_pokemon.body)
    parsed_types = parse_types(decoded["types"])
    parsed_stats = parse_stats(decoded["stats"])
    %Pokemon{id: decoded["id"], name: decoded["name"],
      hp: parsed_stats["hp"], attack: parsed_stats["attack"], defense: parsed_stats["defense"], special_attack: parsed_stats["special-attack"],
      special_defense: parsed_stats["special-defense"], speed: parsed_stats["speed"],
      height: decoded["height"], weight: decoded["weight"], types: parsed_types}
  end
  @doc """
  recursively fetches a list of all pokemon 20 at a time, when it has reached the end of the list uses the above get function to fetch data for all pokemon, takes an arbitrarilly long time and makes a large number of requests to server(not currently recomended to execute.)
  
  """
  def all() do
    url = "https://pokeapi.co/api/v2/pokemon"
    method = :get
    all_pokemon = []
    fetched_list = Finch.build(method, url) |> Finch.request!(MyFinch)
    decoded = Jason.decode!(fetched_list.body)
    all_pokemon = all_pokemon ++ parse_names(decoded["results"])
    next = decoded["next"]
    all(all_pokemon, next, :get)
    
  end
  def all(all_pokemon, url, method) do
    fetched_list = Finch.build(method, url) |> Finch.request!(MyFinch)
    decoded = Jason.decode!(fetched_list.body)
    all_pokemon = all_pokemon ++ parse_names(decoded["results"])
    next = decoded["next"]
    if(next == :nil) do
      Enum.map(all_pokemon, fn pokemon -> get(pokemon) end)
    else
      all(all_pokemon, next, :get)
    end
  end
  def parse_stats(results) do
    Enum.map(results, fn result -> {result["stat"]["name"], result["base_stat"]} end)
    |> Map.new
    
  end
  def parse_types(results) do
    Enum.map(results, fn result -> result["type"]["name"] end)
  end
  def parse_names(results) do
    Enum.map(results, fn result -> result["name"] end)
  end
end
