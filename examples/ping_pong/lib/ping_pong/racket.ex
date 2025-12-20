defmodule PingPong.Racket do
  @moduledoc false

  defmodule State do
    @moduledoc false

    defstruct [:position, :width, :height, :changes]
  end

  def new(%{x: x, y: y, width: width, height: height}) do
    %State{position: %{x: x, y: y}, width: width, height: height, changes: %{}}
  end

  def step(%State{} = state, _env) do
    state
  end

  def render(%State{} = state) do
    [
      {:draw_rectangle,
       %{
         x: state.position.x,
         y: state.position.y,
         width: state.width,
         height: state.height,
         color: :lime
       }}
    ]
  end
end
