defmodule StringMatchers.KMP do
  @moduledoc """
    Knuth–Morris–Pratt algorithm

    see https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm
  """
  require Logger

  def get_table(pattern) do
    pattern = String.codepoints(pattern)
    helper = length_helper(length(pattern))

    build_table(pattern, length(pattern), length(pattern) - 1, [0], helper)
  end

  def get_search_function(pattern) do
    pattern = String.codepoints(pattern)
    helper = length_helper(length(pattern))
    table = build_table(pattern, length(pattern), length(pattern) - 1, [0], helper)

    fn search_string ->
      nil
      # IO.inspect(search_string)
      # IO.inspect(pattern)
      # IO.inspect(table)
    end
  end

  def build_table(_pattern, _, 0, return_list, _helper) do
    Logger.debug("reached base case")
    List.to_tuple(return_list)
  end

  def build_table(pattern, j, i, return_list, helper) do
    ii = helper.(i)
    Logger.debug("correct i: #{inspect(ii)}")
    jj = helper.(j)
    Logger.debug("correct j: #{inspect(jj)}")

    cond do
      Enum.at(pattern, ii, :none) != Enum.at(pattern, jj, :none) ->
        Logger.debug("no match")
        # increment i
        # write zero to return list
        case helper.(j) do
          0 ->
            # inner base case
            Logger.debug("reached inner base case with i = #{inspect(i)}")
            build_table(pattern, j, i - 1, return_list ++ [0], helper)

          _ ->
            # no match and j is not zero
            j = Enum.at(return_list, helper.(j + 1)) |> helper.()
            Logger.debug("no match and reset j to #{inspect(j)}")
            build_table(pattern, j, i, return_list, helper)
        end

      Enum.at(pattern, ii, :none) == Enum.at(pattern, jj, :none) ->
        Logger.debug("match, setting j to #{inspect(j - 1)} and i to #{inspect(i - 1)}")
        build_table(pattern, j - 1, i - 1, return_list ++ [helper.(j) + 1], helper)
    end
  end

  def length_helper(pattern_length) do
    fn index ->
      pattern_length - index
    end
  end

  def search(string, table, pattern) do
    {}
  end
end
