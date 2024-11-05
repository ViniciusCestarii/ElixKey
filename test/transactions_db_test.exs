defmodule ElixKey.TransactionsDBTest do
  use ExUnit.Case

  setup do
    file_path = "test_db_state_#{:os.system_time(:millisecond)}.bin"

    {:ok, _} = ElixKey.TransactionsDB.start_link(file_path)

    on_exit(fn ->
      File.rm(file_path)
    end)

    :ok
  end

  test "GET non-existent key" do
    assert ElixKey.TransactionsDB.get("non_existent_key") == nil
  end

  test "GET existent key" do
    ElixKey.TransactionsDB.set("test_key", "test_value")
    assert ElixKey.TransactionsDB.get("test_key") == "test_value"
  end

  test "SET non-existent key" do
    assert ElixKey.TransactionsDB.set("non_existent_key", "test_value") == :ok
  end

  test "SET existent key" do
    ElixKey.TransactionsDB.set("test_key", "test_value")
    assert ElixKey.TransactionsDB.set("test_key", "test_value") == :ok
  end

  test "SET with key with spaces" do
    assert ElixKey.TransactionsDB.set("key with spaces", "test_value") == :ok
  end

  test "BEGIN" do
    assert ElixKey.TransactionsDB.begin() == :ok
  end

  test "ROLLBACK" do
    ElixKey.TransactionsDB.begin()
    assert ElixKey.TransactionsDB.rollback() == {:ok}
  end

  test "ROLLBACK with no transaction" do
    assert ElixKey.TransactionsDB.rollback() == {:error, :no_transaction_to_rollback}
  end

  test "ROLLBACK after SET" do
    ElixKey.TransactionsDB.begin()
    ElixKey.TransactionsDB.set("test_key", "test_value")
    assert ElixKey.TransactionsDB.rollback() == {:ok}
    assert ElixKey.TransactionsDB.get("test_key") == nil
  end

  test "COMMIT" do
    ElixKey.TransactionsDB.begin()
    assert ElixKey.TransactionsDB.commit() == {:ok}
  end

  test "COMMIT after SET" do
    ElixKey.TransactionsDB.begin()
    ElixKey.TransactionsDB.set("test_key", "test_value")
    assert ElixKey.TransactionsDB.commit() == {:ok}
    assert ElixKey.TransactionsDB.get("test_key") == "test_value"
  end

  test "COMMIT with no transaction" do
    assert ElixKey.TransactionsDB.commit() == {:error, :no_transaction_to_commit}
  end
end
