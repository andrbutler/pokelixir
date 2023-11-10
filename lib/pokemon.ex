defmodule Pokemon do
  @enforce_keys [:id, :name, :hp, :attack, :defense, :special_attack, :special_defense, :speed, :weight, :height, :types]
  defstruct [:id, :name, :hp, :attack, :defense, :special_attack, :special_defense, :speed, :weight, :height, :types]
end
