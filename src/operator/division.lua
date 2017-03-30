return function (Layer, Division)
  local refines = Layer.key.refines

  local multiplication = Layer.require "operator.multiplication"

  Division [refines] = {
    multiplication,
  }

  Division.operator = "/"

  return Division
end
