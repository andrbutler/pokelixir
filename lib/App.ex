defmodule App do
  use Application
  def start(_type, _args) do
    children = 
      [
        {Finch, name: MyFinch}
      ]
    
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
