return function (Layer, and_op)
  local refines    = Layer.key.refines
  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"

  and_op [refines] = {
    operator
  }

  and_op.operator = "^"
  and_op.priority = 12

  and_op.is_associative = true
  and_op.is_commutative = true
  and_op.operands    = {
    [collection] = {
      minimum = 2,
      maximum = 2,
    },
    type = collection,
  }


  return and_op
end
