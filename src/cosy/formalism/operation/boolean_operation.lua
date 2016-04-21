--Boolean Operation

return function (Layer, boolean_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local operation  = Layer.require "cosy/formalism/operation"

  boolean_operation = {
    [refines] = {operation},
  }

  

  return boolean_operation
end
