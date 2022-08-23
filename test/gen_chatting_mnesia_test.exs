defmodule GenChattingMnesiaTest do
  use ExUnit.Case
  doctest GenChattingMnesia

  test "greets the world" do
    assert GenChattingMnesia.hello() == :world
  end
end
