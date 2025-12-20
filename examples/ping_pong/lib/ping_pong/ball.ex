defmodule PingPong.Ball do
  alias PingPong.Collision

  defmodule State do
    use PrivateModule
    defstruct [:position, :speed, :radius, :gravity, :bounce_sound_id, :changes]
  end

  def new(%{x: x, y: y, speed: speed, radius: radius, bounce_sound_id: bounce_sound_id}) do
    %State{
      position: %{x: x, y: y},
      speed: %{x: speed, y: speed},
      radius: radius,
      gravity: 0.0,
      bounce_sound_id: bounce_sound_id,
      changes: %{
        bounce?: false
      }
    }
  end

  def step(%State{} = state, env) do
    speed = state.speed
    position = %{x: state.position.x + speed.x, y: state.position.y + speed.y + state.gravity}
    %{state | position: position, gravity: env.gravity}
  end

  def logic(%State{} = state, %Collision{} = collision) do
    speed_x =
      if(collision.ball_horizontal_collision?,
        do: state.speed.x * -1.0,
        else: state.speed.x
      )

    speed_y =
      if(collision.ball_vertical_collision?,
        do: state.speed.y * -1.0,
        else: state.speed.y
      )

    bounce? =
      collision.ball_horizontal_collision? || collision.ball_vertical_collision?

    %{state | speed: %{x: speed_x, y: speed_y}, changes: %{state.changes | bounce?: bounce?}}
  end

  def render(%State{} = state) do
    [
      {
        :draw_circle_v,
        %{
          center: %{x: state.position.x, y: state.position.y},
          radius: state.radius,
          color: :lime
        }
      }
    ]
    |> then(fn ops ->
      if state.changes.bounce? do
        ops ++ [{:play_sound, %{sound_id: state.bounce_sound_id}}]
      else
        ops
      end
    end)
  end
end
