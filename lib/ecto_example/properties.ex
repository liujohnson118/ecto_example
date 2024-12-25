defmodule EctoExample.Properties do
  alias EctoExample.{Properties.House, Repo}

  def all_houses(params) do
    params
      |> Enum.reduce(House, &convert_field_to_query/2)
      |> Repo.all
  end

  def convert_field_to_query({:between_price, {min_price, max_price}}, query) do
    House.by_gt_than_price(query, min_price)
      |> House.by_lt_than_price(max_price)
  end

  def convert_field_to_query({:price_lt, value}, query) do
    House.by_lt_than_price(query, value)
  end

  def convert_field_to_query({:price_gt, value}, query) do
    House.by_gt_than_price(query, value)
  end

  def convert_field_to_query({:name, value}, query) do
    House.or_by_searched_name(query, value)
  end
end
