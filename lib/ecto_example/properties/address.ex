defmodule EctoExample.Properties.Address do
  use Ecto.Schema

  schema "addresses" do
    field :city, :string

    has_many :houses, EctoExample.Properties.House
  end
end
