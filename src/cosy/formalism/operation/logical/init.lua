--Logical Operation

return function (Layer, logical_operation)

  local refines    =  Layer.key.refines
  local boolean    = Layer.require "cosy/formalism/operation/boolean"

  logical_operation [refines] = {
      boolean,
    }
    
end
