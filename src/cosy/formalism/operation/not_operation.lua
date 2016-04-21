--NOT Operation

return function (Layer, not_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local boolean_operation  = Layer.require "cosy/formalism/boolean_operation"

  not_operation = {
    [refines] = {boolean_operation},
  }

  not_operation[meta][collection].minimum = 1
  not_operation[meta][collection].maximum = 1
  not_operation[meta][collection].operator = "NOT"
  
  return not_operation
end
