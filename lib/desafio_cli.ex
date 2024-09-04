defmodule DesafioCli do
  @moduledoc """
  Ponto de entrada para a CLI.
  """

  @doc """
  A função main recebe os argumentos passados na linha de
  comando como lista de strings e executa a CLI.
  """
  def main(_args) do
    IO.puts(phrase())

    input = IO.gets("Please enter something: ")

    IO.puts("You entered: #{input}")
  end

  def phrase() do
    "Hello, world!"
  end
end
