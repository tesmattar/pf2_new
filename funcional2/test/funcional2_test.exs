defmodule Funcional2Test do
  use ExUnit.Case
  doctest Funcional2

  test "greets the world" do
    assert Funcional2.hello() == :world
  end
end
