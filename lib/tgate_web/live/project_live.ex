defmodule TgateWeb.ProjectLive do
  use Phoenix.LiveView

  alias Tgate.Projects
  alias Tgate.TelegramAccounts

  require Logger

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-7xl">Project: <%= @project.name %></h1>

      <table class="table-auto border-2 border-separate border-slate-500 border-spacing-2">
        <caption class="caption-top text-4xl">
          Abonents
        </caption>
        <thead>
          <tr>
            <th class="border-2 text-2xl">Abonent</th>
            <th class="border-2 text-2xl">Status</th>
            <th class="border-2 text-2xl">Actions</th>
          </tr>
        </thead>
        <tbody>
          <%= for abonent <- @project.abonents do %>
            <tr>
              <td class="border-2 text-xl"><%= abonent.name %></td>
              <td class="border-2 text-xl"><%= abonent.status %></td>
              <td>
                <button
                  type="button"
                  phx-click={"deactivate_abonent:#{abonent.id}"}
                  class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
                >
                  Deactivate
                </button>
                <button
                  type="button"
                  phx-click={"send_code:#{abonent.id}"}
                  class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
                >
                  Send code
                </button>
                <button
                  type="button"
                  phx-click={"reactivate:#{abonent.id}"}
                  class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
                >
                  Reactivate
                </button>
                <button
                  type="button"
                  phx-click={"refresh_code:#{abonent.id}"}
                  class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
                >
                  Refresh code
                </button>
              </td>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    # Showcase hardcode
    {:ok, project} = Projects.fetch_project(1)

    {:ok, assign(socket, :project, project)}
  end

  def handle_event("deactivate_abonent:" <> id, _params, socket) do
    with {:ok, _} <- deactivate_abonent(id),
         {:ok, project} <- Projects.fetch_project(socket.assigns.project.id) do
      {:noreply, update(socket, :project, project)}
    else
      _ ->
        {:noreply, socket}
    end
  end

  def handle_event("send_code:" <> id, _params, socket) do
    case send_code(id) do
      {:ok, _code} ->
        {:noreply, put_flash(socket, :info, "Code sent")}

      {:error, _error} ->
        {:noreply, put_flash(socket, :error, "Failed to send code")}
    end
  end

  def handle_event("reactivate:" <> id, _params, socket) do
    case reactivate(id) do
      {:ok, abonent} ->
        message = "Reactivation code: #{abonent.invite_code}"
        Logger.warning(message)
        {:noreply, put_flash(socket, :info, message)}

      {:error, _error} ->
        {:noreply, put_flash(socket, :error, "Failed to reactivate")}
    end
  end

  def handle_event("refresh_code:" <> id, _params, socket) do
    case refresh_code(id) do
      {:ok, abonent} ->
        message = "Refreshed code: #{abonent.invite_code}"
        Logger.warning(message)
        {:noreply, put_flash(socket, :info, message)}

      {:error, _error} ->
        {:noreply, put_flash(socket, :error, "Failed to send refreshed code")}
    end
  end

  defp send_code(id) do
    id
    |> String.to_integer()
    |> Projects.send_code()
  end

  defp deactivate_abonent(id) do
    id
    |> String.to_integer()
    |> TelegramAccounts.deactivate_abonent()
  end

  defp reactivate(id) do
    id
    |> String.to_integer()
    |> TelegramAccounts.reactivate_abonent()
  end

  defp refresh_code(id) do
    id
    |> String.to_integer()
    |> Projects.refresh_abonent_code()
  end
end
