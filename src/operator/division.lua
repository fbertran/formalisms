return function (Layer, Division)
  local refines = Layer.key.refines

  local multiplication = Layer.require "operator.multiplication"

  Division [refines] = {
    multiplication,
  }

  Division.operator = "/"
  Division.is_commutative = false
  Division.is_associative = false

  return Division
end
