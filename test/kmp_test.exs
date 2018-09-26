defmodule StringMatchersKMPTest do
  use ExUnit.Case
  import StringMatchers.KMP
  doctest StringMatchers

  test "pattern from youtube" do
    assert get_table("abcdabca") == {0, 0, 0, 0, 1, 2, 3, 1}
  end

  test "pattern from youtube II" do
    assert get_table("aabaabaaa") == {0, 1, 0, 1, 2, 3, 4, 5, 2}
  end

  test "performance baseline for get_table" do
    result = hd(Benchwarmer.benchmark(&get_table/1, "abcdabca"))
    assert result.duration < 1_700_000
  end
end
