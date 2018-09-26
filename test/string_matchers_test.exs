defmodule StringMatchersTest do
  use ExUnit.Case
  doctest StringMatchers.KMP

  test "greets the world" do
    assert StringMatchers.hello() == :world
  end
end
