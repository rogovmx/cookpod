defmodule CookpodWeb.CookpodLive do
  use Phoenix.LiveView, layout: {CookpodWeb.LayoutView, "live.html"}

  require Logger

  def mount(_params, _session, socket) do
  	Logger.info("MOUNT #{inspect(self())}")
  	socket = assign(socket, :val, 0)
    {:ok, socket}
  end

  def render(assigns) do
  	Logger.info("RENDER #{inspect(self())}")	
    ~L"""
	  <div>
	    <h1>The count is: <%= @val %></h1>
	    <button phx-click="dec">-</button>
	    <button phx-click="inc">+</button>
	  </div>
    """
  end

  def handle_event("inc", _, socket) do
  {:noreply, update(socket, :val, &(&1 + 1))}
	end

	def handle_event("dec", _, socket) do
	  {:noreply, update(socket, :val, &(&1 - 1))}
	end
end