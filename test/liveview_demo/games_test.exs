defmodule LiveviewDemo.GamesTest do
  use LiveviewDemo.DataCase

  alias LiveviewDemo.Games

  describe "counters" do
    alias LiveviewDemo.Games.Counter

    import LiveviewDemo.GamesFixtures

    @invalid_attrs %{count: nil, name: nil, slug: nil}

    test "list_counters/0 returns all counters" do
      counter = counter_fixture()
      assert Games.list_counters() == [counter]
    end

    test "get_counter!/1 returns the counter with given id" do
      counter = counter_fixture()
      assert Games.get_counter!(counter.id) == counter
    end

    test "create_counter/1 with valid data creates a counter" do
      valid_attrs = %{count: 42, name: "some name", slug: "some slug"}

      assert {:ok, %Counter{} = counter} = Games.create_counter(valid_attrs)
      assert counter.count == 42
      assert counter.name == "some name"
      assert counter.slug == "some slug"
    end

    test "create_counter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_counter(@invalid_attrs)
    end

    test "update_counter/2 with valid data updates the counter" do
      counter = counter_fixture()
      update_attrs = %{count: 43, name: "some updated name", slug: "some updated slug"}

      assert {:ok, %Counter{} = counter} = Games.update_counter(counter, update_attrs)
      assert counter.count == 43
      assert counter.name == "some updated name"
      assert counter.slug == "some updated slug"
    end

    test "update_counter/2 with invalid data returns error changeset" do
      counter = counter_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_counter(counter, @invalid_attrs)
      assert counter == Games.get_counter!(counter.id)
    end

    test "delete_counter/1 deletes the counter" do
      counter = counter_fixture()
      assert {:ok, %Counter{}} = Games.delete_counter(counter)
      assert_raise Ecto.NoResultsError, fn -> Games.get_counter!(counter.id) end
    end

    test "change_counter/1 returns a counter changeset" do
      counter = counter_fixture()
      assert %Ecto.Changeset{} = Games.change_counter(counter)
    end
  end
end
