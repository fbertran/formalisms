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

  return Arithmetic_Grammar
end
