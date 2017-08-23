return function (Layer, arithmetic, ref)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local expression     = Layer.require "expression"
  local literal        = Layer.require "operator.literal"
  local addition       = Layer.require "operator.addition"
  local multiplication = Layer.require "operator.multiplication"
  local substraction   = Layer.require "operator.substraction"

  arithmetic [refines] = {
    expression
  }

  local r_number = {
    [refines] = { literal },
    [meta   ] = { of = "number" },
  }

  local r_addition = {
    [refines] = { addition },
    [meta   ] = { of = ref },
  }

  local r_substraction = {
    [refines] = { substraction },
    [meta   ] = { of = ref },
  }

  local r_multiplication = {
    [refines] = { multiplication },
    [meta   ] = { of = ref },
  }

  arithmetic [meta] = {
    [expression] = {
      number         = r_number,
      multiplication = r_multiplication,
      addition       = r_addition,
      substraction   = r_substraction
    },
  }

  return arithmetic
end
