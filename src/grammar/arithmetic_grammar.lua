return function (Layer, Arithmetic_Grammar, ref)
  local refines = Layer.key.refines
  local meta    = Layer.key

  local add_expr = Layer.require "expression.addition_expression"

  local grammar = Layer.require "grammar"

  Arithmetic_Grammar [refines] = {
    grammar,
  }

  Arithmetic_Grammar.expressions = {
    add_expr,
  }

  Arithmetic_Grammar.expressions[1].operator.operands = {
    10, 20,
  }

  return Arithmetic_Grammar
end
