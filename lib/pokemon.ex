defmodule Pokemon do
  @enforce_keys [:id, :name, :hp, :attack, :defence, :special_attack, :special_defence, :speed, :weight, :height, :types]
  defstruct [:id, :name, :hp, :attack, :defence, :special_attack, :special_defence, :speed, :weight, :height, :types]
end
