defmodule Budget.TransactionController do
  use Budget.Web, :controller

  alias Budget.Transaction

  def index(conn, _params) do
    transactions = Repo.all(Transaction)
    render conn, "index.html", transactions: transactions
  end

  def index_roman(conn, _params) do
    transactions = Repo.all(Transaction)
    render conn, "index_roman.html", transactions: transactions
  end

  def new(conn, _params) do
    changeset = Transaction.changeset(%Transaction{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"transaction" => transaction}) do
    roman_numeral = extract_number(transaction)
    updated_transaction = Map.put(transaction, "roman_numerals", roman_numeral)
    changeset = Transaction.changeset(%Transaction{}, updated_transaction)

    case Repo.insert(changeset) do
      {:ok, _updated_transaction} -> 
        conn
        |> put_flash(:info, "Transaction Added")
        |> redirect(to: transaction_path(conn, :index))

      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => transaction_id}) do
    transaction = Repo.get(Transaction, transaction_id)
    changeset = Transaction.changeset(transaction)

    render conn, "edit.html", changeset: changeset, transaction: transaction
  end

  def update(conn, %{"id" => transaction_id, "transaction" => transaction}) do
    old_transaction = Repo.get(Transaction, transaction_id)
    changeset = Transaction.changeset(old_transaction, transaction)

    case Repo.update(changeset) do
      {:ok, _transaction} ->
        conn
        |> put_flash(:info, "Transaction Updated")
        |> redirect(to: transaction_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, transaction: old_transaction
    end
  end

  def delete(conn, %{"id" => transaction_id}) do
    Repo.get!(Transaction, transaction_id)
    |> Repo.delete!

    conn 
    |> put_flash(:info, "Transaction Deleted")
    |> redirect(to: transaction_path(conn, :index))
  end



  def extract_number(%{"amount" => amount}) do
    amount
    |> String.to_integer
    |> roman_numeral
  end

  def roman_numeral(number) do
    RomanNumeral.convert(number)
  end
  #def import(_conn, _params) do
  #end

end