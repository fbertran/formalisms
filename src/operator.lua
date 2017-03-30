return function (Layer, Operator, ref)
  local meta    = Layer.key.meta
  local refines = Layer.key.refines

  local record     = Layer.require "data.record"
  local collection = Layer.require "data.collection"

  Operator [refines] = {
    record,
  }

  Operator [meta] = {}

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
    },
    operands_type = false,
  }

  Operator.operands = {}

  Operator.operands [refines] = {
    collection,
  }

  Operator.operands [meta] = {
    [collection] = {
      value_type = ref [meta].operands_type,
      minimum  = false,
      maximum  = false,
    },
  }

  return Operator
end
