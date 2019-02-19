defmodule Budget.Repo.Migrations.AlterTransactionTable do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      add :roman_numerals, :string
    end
  end
end
