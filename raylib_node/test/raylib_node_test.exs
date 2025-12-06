defmodule RaylibNodeTest do
  use ExUnit.Case
  doctest RaylibNode

  test "greets the world" do
    assert RaylibNode.hello() == :world
  end
end
