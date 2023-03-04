defmodule NameCountWeb.LivePage do
  use NameCountWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      NameCountWeb.Endpoint.subscribe(topic())
    end

    list_of_names = NameCount.Counts.count_names!(5)

    {:ok, assign(socket, names: list_of_names)}
  end

  def handle_info(%{event: "addName"}, socket) do
    list_of_names = NameCount.Counts.count_names!(5)
    {:noreply, assign(socket, names: list_of_names)}
  end

  def handle_event("send", %{"text" => text}, socket) do
    NameCount.Counts.create_name(%{name: text})
    NameCountWeb.Endpoint.broadcast(topic(), "addName", %{})

    {:noreply, socket}
  end

  defp topic do
    "namesCounter"
  end

  def render(assigns) do
    ~L"""
    <div>
      <h1>Names counter</h1>
      <form phx-submit="send">
        <input style="width: 200px" type="text" name="text" />
        <button type="submit">Send</button>
      </form>
      <div class="messages" style="border: 1px solid #eee; height: 400px; overflow: scroll; margin-bottom: 8px;">
        <%= for n <- @names do %>
          <p style="margin: 2px;"><%= n.name%>: <%= n.count %></p>
        <% end %>
      </div>
    </div>
    """
  end
end
