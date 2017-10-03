return function (Layer, arithmetic_no_multiplication, ref)
  local refines    = Layer.key.refines
  local meta       = Layer.key.meta
  local deleted    = Layer.key.deleted
  local arithmetic = Layer.require "expression.arithmetic"
  local expression = Layer.require "expression"

  arithmetic_no_multiplication [refines] = { arithmetic }

  arithmetic_no_multiplication [meta] [expression].multiplication = deleted

  return arithmetic_no_multiplication
end
