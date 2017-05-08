return function (Layer, And)
  local refines = Layer.key.refines
  local operator = Layer.require "operator"
  local collection = Layer.require "data.collection"

  And [refines] = {
    operator
  }

  And.operator = "^"
  And.priority = 12

  And.is_associative = true
  And.is_commutative = true
  And.operands = {
    [collection] = {
      minimum = 2,
      maximum = 2,
      value_type = "boolean"
    },
    type = collection,
  }


  return And
end
