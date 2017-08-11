return function (Layer, addition_expression, ref)
  local refines = Layer.key.refines

  local expression = Layer.require "expression"
  local addition   = Layer.require "operator.addition"
  local literal    = Layer.require "operator.literal"

  addition_expression [refines] = {
    expression
  }

  local r_number = {
    [refines] = literal,
    [meta   ] = { of = "number" },
  }

  local r_add = {
    [refines] = { addition },
    [meta   ] = { of = ref },
  }

  addition_expression [meta] = {
    [expression] = {
      number   = r_number,
      addition = r_add,
    },
  }

  return addition_expression
end
