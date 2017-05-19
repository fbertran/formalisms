return function (Layer, arithmetic_var, ref)
  local refines      = Layer.key.refines
  local meta         = Layer.key.meta
  local arithmetic   = Layer.require "expression.arithmetic"
  local literal      = Layer.require "operator.literal"
  local collection   = Layer.require "data.collection"
  local expression   = Layer.require "expression"

  arithmetic_var [refines] = {
    arithmetic
  }

  local r_variable = {
    [refines] = { literal },
    operands  = {
      [meta] = {
        [collection] = {
          value_type = ref [meta] .type
        },
      },
    },
  }

  arithmetic_var [meta] = {
    [expression] = {
       variable = r_variable
     },
     type = arithmetic_var,
  }

  return arithmetic_var
end
