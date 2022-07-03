defmodule SmartCellIexSyntax.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Kino.SmartCell.register(SmartCellIexSyntax)
    children = []

    opts = [strategy: :one_for_one, name: SmartCellIexSyntax.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
