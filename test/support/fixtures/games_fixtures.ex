defmodule LiveviewDemo.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveviewDemo.Games` context.
  """

  @doc """
  Generate a unique counter name.
  """
  def unique_counter_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique counter slug.
  """
  def unique_counter_slug, do: "some slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a counter.
  """
  def counter_fixture(attrs \\ %{}) do
    {:ok, counter} =
      attrs
      |> Enum.into(%{
        count: 42,
        name: unique_counter_name(),
        slug: unique_counter_slug()
      })
      |> LiveviewDemo.Games.create_counter()

    counter
  end
end
