return function (Layer, Addition)
  local refines = Layer.key.refines

  local operator = Layer.require "operator"

  local collection = Layer.require "data.collection"

  Addition [refines] = {
    operator
  }

  Addition.operator = "+"
  Addition.priority = 11

  Addition.is_associative = true
  Addition.is_commutative = true
  Addition.operands = {
    [collection] = {
      minimum = 2,
      maximum = 2,
    },
    type = collection,
  }

  return Addition
end
