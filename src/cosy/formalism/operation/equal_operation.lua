--Equal Operation

return function (Layer, equal_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/relational_operation"

  equal_operation = {
    [refines] = {relational_operation},
  }

  equal_operation[meta][collection].minimum = 2
  equal_operation[meta][collection].maximum = 2
  equal_operation[meta][collection].operator = "="
  
  return equal_operation
end
