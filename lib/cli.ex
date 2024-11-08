defmodule ElixKey do
  def main(_args) do
    start_db()
    loop()
  end

  @db_file_path "db_state.bin"
  defp start_db() do
    {:ok, _} = ElixKey.TransactionsDB.start_link(@db_file_path)
  end

  def loop() do
    IO.write("> ")
    command = IO.gets("")

    case command do
      :eof ->
        IO.puts("End of input detected. Exiting...")
        :ok

      _ ->
        command = command |> String.trim()

        case ElixKey.Parser.parse_command(command) do
          {:ok, :set, key, value} ->
            handle_set(key, value)

          {:ok, :get, key} ->
            handle_get(key)

          {:ok, :exists, key} ->
            handle_exists(key)

          {:ok, :delete, key} ->
            handle_delete(key)

          {:ok, :begin} ->
            handle_begin()

          {:ok, :commit} ->
            handle_commit()

          {:ok, :rollback} ->
            handle_rollback()

          {:ok, :exit} ->
            IO.puts("Exiting...")

          {:error, :syntax_error, message} ->
            handle_error("#{message} - Syntax error")

          {:error, message} ->
            handle_error(message)
        end

        unless command == "EXIT" do
          loop()
        end
    end
  end

  defp handle_set(key, value_data) do
    old_value = ElixKey.TransactionsDB.get(key)
    ElixKey.TransactionsDB.set(key, ElixKey.Transformer.to_model_value(value_data))

    case old_value do
      nil -> IO.puts("FALSE #{value_data.value}")
      ^old_value -> IO.puts("TRUE #{value_data.value}")
    end
  end

  defp handle_get(key) do
    case ElixKey.TransactionsDB.get(key) do
      nil ->
        IO.puts("NIL")

      db_value ->
        case ElixKey.Parser.parse_value(db_value) do
          {:ok, value_data} -> IO.puts(value_data.value)
          {:error, message} -> handle_error(message)
        end
    end
  end

  defp handle_exists(key) do
    case ElixKey.TransactionsDB.exists?(key) do
      true -> IO.puts("TRUE")
      false -> IO.puts("FALSE")
    end
  end

  defp handle_delete(key) do
    case ElixKey.TransactionsDB.delete?(key) do
      true -> IO.puts("TRUE")
      false -> IO.puts("FALSE")
    end
  end

  defp handle_begin() do
    ElixKey.TransactionsDB.begin()
    print_transaction_stack_length()
  end

  defp handle_commit() do
    case ElixKey.TransactionsDB.commit() do
      {:ok} -> print_transaction_stack_length()
      {:error, :no_transaction_to_commit} -> handle_error("No transaction to commit")
    end
  end

  defp handle_rollback() do
    case ElixKey.TransactionsDB.rollback() do
      {:ok} -> print_transaction_stack_length()
      {:error, :no_transaction_to_rollback} -> handle_error("No transaction to rollback")
    end
  end

  defp handle_error(message) do
    IO.puts( IO.ANSI.red() <> "ERR \"#{message}\"" <> IO.ANSI.reset())
  end

  defp print_transaction_stack_length() do
    nesting_level = ElixKey.TransactionsDB.get_transaction_stack_length()
    IO.puts(nesting_level)
  end
end
