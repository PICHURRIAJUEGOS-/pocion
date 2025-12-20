defmodule PingPong.Racket do
  @moduledoc false

  defmodule State do
    @moduledoc false

    defstruct [:x, :y, :width, :height, :changes]
  end

  def new(%{x: x, y: y, width: width, height: height}) do
    %State{x: x, y: y, width: width, height: height, changes: %{}}
  end

  def step(%State{} = state, _env) do
    state
  end

  def render(%State{} = state) do
    [
      {:draw_rectangle,
       %{x: state.x, y: state.y, width: state.width, height: state.height, color: :lime}}
    ]
  end
end
