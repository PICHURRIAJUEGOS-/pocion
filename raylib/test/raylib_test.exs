defmodule RaylibTest do
  use ExUnit.Case

  test "operations" do
    assert Raylib.init_window(640, 480, "jeje") == :ok
    assert Raylib.set_target_fps(60) == :ok
    assert Raylib.window_should_close() == false

    Raylib.execute([
      %{op: :begin_drawing, args: %{}},
      %{op: :clear_background, args: %{color: :raywhite}},
      %{op: :draw_fps, args: %{x: 10, y: 10}},
      %{
        op: :draw_text,
        args: %{text: "carajo", x: 100, y: 100, font_size: 20, color: :lightgray}
      },
      %{op: :end_drawing, args: %{}}
    ])

    Process.sleep(1000)
    assert Raylib.close_window() == :ok
  end
end
