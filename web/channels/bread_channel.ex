defmodule BreadFixed.BreadChannel do
  use BreadFixed.Web, :channel
  alias BreadFixed.Bread

  def join("bread:fixed", payload, socket) do
    if authorized?(payload) do
      send self(), :after_join
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("request_bread", payload, socket) do
    bread = Repo.get!(Bread, 1)
    params = %{fixed: payload}
    changeset = Bread.changeset(bread, params)

    case Repo.update(changeset) do
      {:ok, bread} ->
        broadcast socket, "set_bread", bread
        {:noreply, socket}
      {:error, _changeset} ->
        {:reply, {:error, "Something went wrong."}, socket}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (bread:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  def handle_info(:after_join, socket) do
    breads = Repo.all(Bread)

    if Enum.count(breads) > 0 do
      push socket, "set_bread", %{bread: hd(breads)}
    end
    {:noreply, socket}
  end
end
