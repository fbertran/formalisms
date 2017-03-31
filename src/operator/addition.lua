return function (Layer, Addition)
  local refines = Layer.key.refines

  local infix      = Layer.require "operator.infix"
  local arithmetic = Layer.require "operator.arithmetic"

  Addition [refines] = {
    infix,
    arithmetic,
  }

  Addition.operator = "+"
  -- TODO: decide on priority values,
  -- "+" is less than "*" and "/" which are less than let's say "!" ("not" operator),
  -- so if "maximum value" for priorities is 13, this should be 11
  Addition.priority = 11

  return Addition
end
