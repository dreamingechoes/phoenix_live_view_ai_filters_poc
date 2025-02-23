defmodule PhoenixLiveViewAiFiltersPoc.Projects.Services.BuildProjectFilters do
  @moduledoc """
  Builds the filters for the projects based on the query specified by the user.
  """

  @model "gpt-4-turbo"
  @role_content """
  Generate a JSON object with project filters based on the user's query.

  ## Filtering Options:
  - `code`: Project code.
  - `estimation`: Project estimation (`extra_small`, `small`, `medium`, `large`, `extra_large`).
  - `name`: Project name.
  - `status`: Project status (`active`, `done`, `archived`, `deleted`, `draft`).
  - `target_date`: Project target date (use the current date as a reference: #{Date.utc_today()}).
  - `type`: Project type (`internal`, `external`).

  ## Sorting Options:
  - `sort_by`: Field to sort projects by.
  - `order`: Sorting order (`asc` by default).

  ### Example Output:
  ```json
  {
    "estimation": "small",
    "name": "Project 1",
    "status": "draft",
    "target_date": ["2022-01-01", "2022-12-31"]
  }
  ```

  Instructions:
    * Extract the relevant filters based on the user's query.
    * Return only a valid JSON object, without explanations, comments, or markdown.
    * Ensure date-related filters use today's date as a reference: #{Date.utc_today()}.
  """

  @spec call(String.t()) :: map()
  def call(query) do
    get_filters(query)
  end

  defp get_filters(query) do
    OpenAI.chat_completion(
      model: @model,
      messages: [
        %{role: "system", content: @role_content},
        %{role: "user", content: query}
      ]
    )
    |> case do
      {:ok, %{choices: choices}} ->
        result = List.first(choices)

        {:ok, get_result_content(result)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp get_result_content(%{"message" => %{"content" => content}}) do
    Jason.decode!(content, keys: :atoms!)
  end

  defp get_result_content(_), do: %{}
end
