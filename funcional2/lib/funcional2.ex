defmodule Funcional2 do

  def deriva([_variables, _terminals, axiom, rules], n) do
    Enum.reduce(1..n, axiom, fn _, acc ->
      acc
      |> String.graphemes()
      |> Enum.map(fn symbol -> Map.get(rules, symbol, symbol) end)
      |> Enum.join()
    end)
  end


def lsystem_to_turtle_commands(sequence, step \\ 10, angle \\ 90) do
    commands =
      sequence
      |> String.graphemes()
      |> Enum.map(fn

        "F" -> "t.forward(#{step})"
        "M" -> "t.penup()\nt.forward(#{step})\nt.pendown()"  # anda sem desenhar


        "+" -> "t.right(#{angle})"
        "-" -> "t.left(#{angle})"
        "A" -> "t.right(#{angle / 2})"
        "a" -> "t.left(#{angle / 2})"


        "[" -> "stack.append((t.position(), t.heading(), t.pencolor(), t.pensize()))"
        "]" ->

          """
          pos, head, color, size = stack.pop()
          t.penup()
          t.setposition(pos)
          t.setheading(head)
          t.pencolor(color)
          t.pensize(size)
          t.pendown()
          """

        "R" -> "t.pencolor('red')"
        "G" -> "t.pencolor('green')"
        "B" -> "t.pencolor('blue')"

        "T" -> "t.pensize(t.pensize() + 1)"
        "t" -> "t.pensize(max(1, t.pensize() - 1))"

        _ -> nil
      end)
      |> Enum.filter(& &1)
      |> Enum.join("\n")


    python_code = """
    import turtle as t

    stack = []

    t.speed(0)
    t.pensize(2)

    #{commands}

    t.done()
    """
File.write("lsystem_output.py", python_code)
    end

  def verifica_derivacao(lsystem, string, n) do
    derivada = deriva(lsystem, n)
    derivada == string
  end
end
