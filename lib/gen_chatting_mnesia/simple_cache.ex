defmodule GenChattingMnesia.SimpleCache do
  use GenServer
  alias :mnesia, as: Mnesia

  def start_link(_init_arg) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    Mnesia.create_schema([node()])
    Mnesia.start()
    Mnesia.create_table(ChattingRoom, attributes: [:room_name, :client_list])
    {:ok, init_arg}
  end

  def get(room_name) do
    GenServer.call(__MODULE__, {:get, room_name})
  end

  def set(room_name, client_list) do
    GenServer.cast(__MODULE__, {:set, room_name, client_list})
  end

  @impl true
  def handle_call({:get, room_name}, _from, state) do
    case Mnesia.dirty_read({ChattingRoom, room_name}) do
      [{_ChattingRoom, _room_name, client_list}] -> {:reply, client_list, state}
      [] -> {:reply, [], state}
    end
  end

  @impl true
  def handle_cast({:set, room_name, client_list}, state) do
    Mnesia.dirty_write({ChattingRoom, room_name, client_list})
    {:noreply, state}
  end
end
