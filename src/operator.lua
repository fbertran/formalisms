return function (Layer, Operator)
  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local record  = Layer.require "data.record"

  Operator [refines] = {
    record,
  }

  Operator [meta] = {
    [record] = {
      operator = {
        value_type = "string",
        optional   = true,
      },
      priority = {
        value_type = "number",
        optional   = true,
      },
      is_associative = {
        value_type = "boolean",
        optional   = false,
      },
      is_commutative = {
        value_type = "boolean",
        optional   = false,
      },
      operands = false,
    },
  }

  Operator.is_associative = false
  Operator.is_commutative = false

  return Operator
end
