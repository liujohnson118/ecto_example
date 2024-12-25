defmodule EctoExample.Repo.Migrations.CreateAddressesTable do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :city, :string
    end
  end
end
