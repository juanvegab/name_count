defmodule NameCountWeb.LivePage do
  use NameCountWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      NameCountWeb.Endpoint.subscribe(topic())
    end

    list_of_names = NameCount.Counts.count_names!(10)

    {:ok, assign(socket, names: list_of_names, sentName: nil, nameCount: nil)}
  end

  def handle_info(%{event: "addName", payload: payload}, socket) do
    list_of_names = NameCount.Counts.count_names!(10)
    name_count = NameCount.Counts.count_name!(payload.name)

    {:noreply,
     assign(socket, names: list_of_names, sentName: payload.name, nameCount: name_count)}
  end

  def handle_event("send", %{"text" => text}, socket) do
    NameCount.Counts.create_name(%{name: text})
    NameCountWeb.Endpoint.broadcast(topic(), "addName", %{name: text})

    {:noreply, socket}
  end

  defp topic do
    "namesCounter"
  end

  def render(assigns) do
    ~L"""
    <div class="py-20 w-full flex flex-col items-center">
      <h1 class="text-2xl md:text-3xl pb-4 font-bold">What's your name?</h1>
      <p class="text-md">Write your name and check if it is on the top 10.</p>
      <form class="w-full my-6 flex flex-col items-center" phx-submit="send">
        <input class="w-3/5 md:w-1/2 lg:w-2/5 xl:w-1/3 mb-2 px-10 rounded-md border-blue-500" type="text" name="text" placeholder="Your name" />
        <button class="w-3/5 md:w-1/2 lg:w-2/5 xl:w-1/3 mb-4 display-block bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" type="submit">Submit</button>
      </form>
      <%= unless is_nil(@sentName) do %>
        <div class="mb-8 py-4 border-y w-3/5 md:w-1/2 lg:w-2/5 xl:w-1/3">
          <p class="text-center text-4xl font-bold">Hello <span class="text-blue-500"><%= @sentName%></span>, welcome!</p>
          <p class="mt-4 text-center">Your name has been submitted <%= @nameCount%> time<%= if @nameCount > 1, do: "s", else: ""%>.</p>
        </div>
      <% end %>
      <%= unless length(@names) == 0 do %>
        <div class="w-3/5 md:w-1/2 lg:w-2/5 xl:w-1/3 flex flex-col items-center">
          <p class="text-2xl md:text-3xl font-bold text-center">Top 10 names</p>
          <ul class="w-2/3 my-4 text-base">
            <%= for n <- @names do %>
              <li class="px-2 flex justify-between odd:bg-white even:bg-slate-100">
                <span><%= n.name%></span> <span><%= n.count %></span>
              </li>
            <% end %>
          </ul>
        </div>
      <% end %>
    </div>
    """
  end
end
