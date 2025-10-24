  opção de teste
  
   variables = ["F"]
terminals = ["+", "-"]
axiom = "F--F--F"
rules = %{
  "F" => "F+F--F+F"
}

sequence = Funcional2.deriva([variables, terminals, axiom, rules], 3)

Funcional2.lsystem_to_turtle_commands(sequence, 5, 60)
