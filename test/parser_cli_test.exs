defmodule ElixKey.ParserTest do
  use ExUnit.Case

  test "can't SET numeric key" do
    assert ElixKey.Parser.parse_command("SET 12 teste") ==
             {:error, :syntax_error, "Numeric keys are not allowed"}
  end

  test "can SET key with spaces" do
    assert ElixKey.Parser.parse_command("SET 'key with spaces' teste") ==
             {:ok, :set, "key with spaces", %{type: :string, value: "teste"}}
  end

  test "invalid command" do
    assert ElixKey.Parser.parse_command("INVALID") ==
             {:error, "No command INVALID"}
  end
end
