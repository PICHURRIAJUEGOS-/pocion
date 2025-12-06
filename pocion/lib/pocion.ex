defmodule Pocion do
  require Logger

  defstruct [:root_node, :node]

  def create_window(width, height, title) do
    {root_node, domain} = start_root_node()

    Logger.info("root_node #{root_node}")

    callback_pid = self_as_callback(node_name(domain))

    case start_raylib_node({callback_pid, root_node}, node_name(domain)) do
      {:ok, node} ->
        self = %__MODULE__{node: node, root_node: root_node}
        :ok = raylib(self, :init_window, [width, height, title])

        {:ok, self}
    end
  end

  def close_window(%__MODULE__{} = self) do
    :ok = raylib(self, :close_window, [])
    halt(self)
  end

  defp self_as_callback(name) do
    case Process.info(self()) |> Keyword.get(:registered_name) do
      nil ->
        Process.register(self(), name)
        name

      name ->
        name
    end
  end

  defp start_raylib_node(root_node, node) do
    elixir_path = System.find_executable("elixir")

    port =
      Port.open({:spawn_executable, elixir_path}, [
        :stderr_to_stdout,
        :use_stdio,
        :binary,
        args: node_args(root_node, node)
      ])

    wait_node_started(port)
  end

  defp wait_node_started(port) do
    port_ref = Port.monitor(port)

    loop = fn loop ->
      receive do
        {:node_started, node, _node_pid} ->
          IO.inspect("node started #{node}")
          {:ok, {node, port}}

        {^port, {:data, data}} ->
          IO.inspect(data)
          loop.(loop)

        {:DOWN, ^port_ref, :port, _, reason} ->
          raise "terminated unexpectedly: #{reason}"
      after
        10000 ->
          raise "fails to start node"
      end
    end

    loop.(loop)
  end

  defp node_args(root_node, node) do
    [
      "--erl",
      "-noinput",
      "--hidden",
      "--eval",
      "System.argv() |> hd() |> Base.decode64!() |> Code.eval_string()",
      setup_node(root_node, node)
    ]
  end

  defp setup_node({root_pid, root_node}, current_node) do
    quote bind_quoted: [root_pid: root_pid, root_node: root_node, current_node: current_node] do
      Mix.install([{:raylib, "~> 0.0", path: "../raylib"}])
      {:ok, _} = Node.start(current_node, name_domain: :shortnames, hidden: true)
      Process.register(self(), :pocion)
      true = Node.connect(root_node)
      send({root_pid, root_node}, {:node_started, Node.self(), self()})

      defmodule RPC do
        def loop do
          receive do
            :halt ->
              System.halt()
          end
        end
      end

      RPC.loop()
    end
    |> Macro.to_string()
    |> Base.encode64()
  end

  defp halt(%__MODULE__{node: {node, _}}) do
    :rpc.call(node, System, :halt, [])
  end

  defp raylib(%__MODULE__{node: {node, _}}, fun, args) do
    :rpc.call(node, Raylib, fun, args)
  end

  defp start_root_node() do
    case Node.start(:pocion, name_domain: :shortnames, hidden: false) do
      {:ok, _node_pid} ->
        [_name, domain] = Node.self() |> to_string() |> String.split("@", parts: 2)
        {Node.self(), domain}

      {:error, {:already_started, _}} ->
        [_name, domain] = Node.self() |> to_string() |> String.split("@", parts: 2)
        {Node.self(), domain}
    end
  end

  defp node_name(domain) do
    name = :crypto.strong_rand_bytes(5) |> Base.encode16()
    String.to_atom("#{name}@#{domain}")
  end
end
