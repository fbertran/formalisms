return function (Layer, arithmetic_var, ref)
  local refines    = Layer.key.refines
  local meta       = Layer.key.meta
  local arithmetic = Layer.require "expression.arithmetic"
  local literal    = Layer.require "operator.literal"
  local expression = Layer.require "expression"

  arithmetic_var [refines] = {
    arithmetic,
  }

  local r_variable = {
    [refines] = { literal },
    [meta   ] = { of = "string" },
  }

  arithmetic_var [meta] [expression].variable = r_variable

  return arithmetic_var
end
