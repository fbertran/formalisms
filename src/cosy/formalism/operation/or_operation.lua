--Addition Operation

return function (Layer, or_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local logical_operation  = Layer.require "cosy/formalism/logical_operation"

  or_operation = {
    [refines] = {logical_operation},
  }

  or_operation[meta][collection].minimum = 2
  or_operation[meta][collection].maximum = math.huge
  or_operation[meta][collection].operator = "OR"
  
  return or_operation
end
