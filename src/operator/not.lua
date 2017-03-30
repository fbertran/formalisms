return function (Layer, Not)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local prefix  = Layer.require "operator.prefix"
  local boolean = Layer.require "operator.boolean"

  Not [refines] = {
    prefix,
    boolean,
  }
  
  Not.operator = "!"
  Not.priority = 13 -- TODO: Decide what the highest priority should be. "

  return Not
end
