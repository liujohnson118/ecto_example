defmodule EctoExample.Properties.House do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  schema "houses" do
    field :is_occupied, :boolean
    field :name, :string
    field :price, :integer

    belongs_to :address, EctoExample.Properties.Address

    many_to_many :owners, EctoExample.Properties.Owner, join_through: "owners_houses"
  end

  @available_fields ~w(name price is_occupied address_id)a
  @required_fields ~w(price)a
  def changeset(house = %EctoExample.Properties.House{}, attrs) do
    house
      |> EctoExample.Repo.preload(:owners)
      |> cast(attrs, @available_fields)
      |> validate_required(@required_fields)
      |> validate_number(:price, greater_than: 0, message: "The price has to be greater than 0")
      |> validate_length(:name, min: 1, max: 10, message: "Must be between 1 and 10 characters")
      |> cast_assoc(:owners)
  end

  @spec by_gt_than_price(any(), any()) :: Ecto.Query.t()
  def by_gt_than_price(query \\ EctoExample.Properties.House, price) do
    where(query, [h], h.price > ^price)
  end

  @spec by_lt_than_price(any(), any()) :: Ecto.Query.t()
  def by_lt_than_price(query \\ EctoExample.Properties.House, price) do
    where(query, [h], h.price < ^price)
  end

  @spec or_by_searched_name(any(), any()) :: Ecto.Query.t()
  @spec or_by_searched_name(any()) :: Ecto.Query.t()
  def or_by_searched_name(query \\ EctoExample.Properties.House, name) do
    search_query = "%#{name}%"
    or_where(query, [h], like(h.name, ^search_query))
  end

  def join_address(query \\ EctoExample.Properties.House) do
    join(query, :inner, [h], a in assoc(h, :address), as: :address)
  end

  def by_address(query \\ join_address(), address) do
    where(query, [address: a], a.city == ^address)
  end
end
