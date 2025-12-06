defmodule PocionTest do
  use ExUnit.Case

  test "single window" do
    assert {:ok, w} = Pocion.create_window(640, 480, a_name())
    Pocion.close_window(w)
  end

  test "multi window" do
    assert {:ok, w} = Pocion.create_window(640, 480, a_name())
    assert {:ok, w2} = Pocion.create_window(640, 480, a_name())
    Pocion.close_window(w)
    Pocion.close_window(w2)
  end

  defp a_name do
    :crypto.strong_rand_bytes(5) |> Base.encode16()
  end
end
