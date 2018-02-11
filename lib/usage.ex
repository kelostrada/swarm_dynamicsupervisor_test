defmodule MyApp.ExampleUsage do

  @doc """
  Starts worker and registers name in the cluster
  """
  def start_worker(name) do
    {:ok, _pid} = MyApp.Supervisor.start_child(name)
  end

  def crash(name) do
    GenServer.call({:via, :swarm, name}, :crash)
  end
end
