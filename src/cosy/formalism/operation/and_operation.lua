--Addition Operation

return function (Layer, and_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local logical_operation  = Layer.require "cosy/formalism/logical_operation"

  and_operation = {
    [refines] = {logical_operation},
  }

  and_operation[meta][collection].minimum = 2
  and_operation[meta][collection].maximum = math.huge
  and_operation[meta][collection].operator = "AND"
  
  return and_operation
end
