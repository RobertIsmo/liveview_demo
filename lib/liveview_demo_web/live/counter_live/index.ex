defmodule LiveviewDemoWeb.CounterLive.Index do
  use LiveviewDemoWeb, :live_view

  alias LiveviewDemo.Games
  alias LiveviewDemo.Games.Counter

  @impl true
  def mount(_params, _session, socket) do
    counters = Games.list_counters()
    # LiveviewDemoWeb.Endpoint.subscribe("counter")
    
    {:ok, stream(socket, :counters, counters)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Counter")
    |> assign(:counter, Games.get_counter!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Counter")
    |> assign(:counter, %Counter{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Counters")
    |> assign(:counter, nil)
  end

  @impl true
  def handle_info({LiveviewDemoWeb.CounterLive.FormComponent, {:saved, counter}}, socket) do
    {:noreply, stream_insert(socket, :counters, counter)}
  end

  def handle_info(%{topic: "counter:" <> _id, payload: counter}, socket) do
    socket = stream_insert(socket, :counters, counter)
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    counter = Games.get_counter!(id)
    {:ok, _} = Games.delete_counter(counter)

    {:noreply, stream_delete(socket, :counters, counter)}
  end

  def handle_event("increment", %{"id" => id}, socket) do
    counter = Games.get_counter!(id)
    counter = Games.increment_counter(counter, 1)
    # LiveviewDemo.Endpoint.broadcast_from(self(), "counter", "update", counter)
    
    socket = stream_insert(socket, :counters, counter)
    {:noreply, socket}
  end

  def handle_event("decrement", %{"id" => id}, socket) do
    counter = Games.get_counter!(id)
    counter = Games.increment_counter(counter, -1)
    # LiveviewDemo.Endpoint.broadcast_from(self(), "counter", "update", counter)

    socket = stream_insert(socket, :counters, counter)
    {:noreply, socket}
  end
end
