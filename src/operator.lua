return function (Layer, operator)

  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local record  = Layer.require "data.record"

  operator [refines] = {
    record,
  }

  operator [meta] = {
    [record] = {
      -- operator = {
      --   value_type = "string",
      --   optional   = true,
      -- },
      -- priority = {
      --   value_type = "number",
      --   optional   = true,
      -- },
      -- is_associative = {
      --   value_type = "boolean",
      --   optional   = false,
      -- },
      -- is_commutative = {
      --   value_type = "boolean",
      --   optional   = false,
      -- },
      -- operands = false,
    },
  }

  -- operator.is_associative = false
  -- operator.is_commutative = false

  return operator
end
