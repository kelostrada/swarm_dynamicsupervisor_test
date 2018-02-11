defmodule MyApp.Supervisor do
  @moduledoc """
  This is the supervisor for the worker processes you wish to distribute
  across the cluster, Swarm is primarily designed around the use case
  where you are dynamically creating many workers in response to events. It
  works with other use cases as well, but that's the ideal use case.
  """
  use Swarm.DynamicSupervisor

  def start_link(_) do
    Swarm.DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    Swarm.DynamicSupervisor.init(strategy: :one_for_one)
  end

  @doc """
  Registers a new worker, and creates the worker process

  Notice that there is a required field `id` in child_spec. It's used for registering
  name of process in Swarm. You no longer have to call `Swarm.register_name/5`
  explicitly anymore.
  """
  def start_child(name) do
    spec = Supervisor.child_spec(MyApp.Worker, id: name, start: {MyApp.Worker, :start_link, [name]})
    Swarm.DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
