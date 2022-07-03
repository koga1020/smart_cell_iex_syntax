defmodule SmartCellIexSyntax do
  @moduledoc false

  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Code(IEx syntax)"

  @impl true
  def init(attrs, ctx) do
    code = attrs["code"] || ""
    {:ok, assign(ctx, code: code), editor: [attribute: "code", language: "elixir"]}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{}, ctx}
  end

  @impl true
  def to_attrs(_), do: %{}

  @impl true
  def to_source(attrs) do
    quote do
        unquote(attrs["code"])
        |> String.replace("iex> ", "")
        |> String.replace("...> ", "")
        |> Code.eval_string()
        |> elem(0)
    end
    |> Kino.SmartCell.quoted_to_string()
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
    }
    """
  end
end
