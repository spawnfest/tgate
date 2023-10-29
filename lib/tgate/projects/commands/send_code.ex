defmodule Tgate.Projects.Commands.SendCode do
  import Ecto.Query

  alias Tgate.Projects.Schemas.Abonent

  alias Tgate.Repo

  @bot_token Application.compile_env!(:tgate, :bot_token)

  @spec execute(abonent_id :: integer()) ::
          {:ok, String.t()} | {:error, :abonent_not_active | :not_found | :abonent_unreachable}
  def execute(abonent_id) do
    with {:ok, abonent} <- fetch_abonent(abonent_id) do
      generate_code_and_send(abonent)
    end
  end

  defp fetch_abonent(id) do
    Abonent
    |> by_id(id)
    |> Repo.fetch_one()
  end

  defp by_id(query, id) do
    where(query, [a], a.status == ^"active" and a.id == ^id)
  end

  defp generate_code_and_send(%Abonent{} = abonent) do
    with code <- generate_code(),
         :ok <- send_code(abonent, code) do
      {:ok, code}
    else
      {:error, :abonent_unreachable} ->
        deactivate_abonent(abonent)
        {:error, :abonent_unreachable}

      {:error, :abonent_not_active} ->
        {:error, :abonent_not_active}
    end
  end

  defp generate_code do
    NimbleTOTP.verification_code("not_a_secret")
  end

  defp send_code(%Abonent{status: "active", telegram_id: telegram_id}, code)
       when is_integer(telegram_id) do
    case Telegram.Api.request(@bot_token, "sendMessage",
           chat_id: telegram_id,
           text: "Your code: #{code}"
         ) do
      {:ok, _} ->
        :ok

      {:error, _} ->
        {:error, :abonent_unreachable}
    end
  end

  defp send_code(_abonent, _code), do: {:error, :abonent_not_active}

  defp deactivate_abonent(abonent) do
    abonent
    |> Abonent.deactivate_changeset(%{status: "deactivated"})
    |> Repo.update()
  end
end
