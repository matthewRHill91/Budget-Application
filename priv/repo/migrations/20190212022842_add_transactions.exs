defmodule Budget.Repo.Migrations.AddTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :transaction, :string
      add :category, :string
      add :amount, :float
    end
  end
end
