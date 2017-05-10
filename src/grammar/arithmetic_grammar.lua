return function (Layer, Arithmetic_Grammar)
  local refines = Layer.key.refines

  local add_expr = Layer.require "expression.addition_expression"

  local grammar = Layer.require "grammar"

  Arithmetic_Grammar [refines] = {
    grammar,
  }

  Arithmetic_Grammar.expressions = {
    add_expr,
  }

  Arithmetic_Grammar.expressions[1].operands = {
    10, 20,
  }

  return Arithmetic_Grammar
end
