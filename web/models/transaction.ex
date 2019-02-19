defmodule Budget.Transaction do
  use Budget.Web, :model

  schema "transactions" do
    field :transaction, :string
    field :category, :string
    field :amount, :float
    field :roman_numerals, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:transaction, :category, :amount, :roman_numerals])
    |> validate_required([:transaction, :category, :amount])
    #|> validate_format(:amount)
  end

end