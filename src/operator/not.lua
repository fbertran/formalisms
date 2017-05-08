return function (Layer, Not)
  local refines = Layer.key.refines

  local operator = Layer.require "operator"
  local collection = Layer.require "data.collection"

  Not [refines] = {
    operator,
  }

  Not.operator = "!"
  Not.priority = 13

  Not.is_associative = false
  Not.is_commutative = false
  Not.operands = {
    [collection] = {
      minimum = 1,
      maximum = 1,
      value_type = "boolean",
    },
    type = collection,
  }

  return Not
end
