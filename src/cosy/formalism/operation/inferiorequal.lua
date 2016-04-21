--InferiorEqual Operation

return function (Layer, inferiorequal_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/relational_operation"

  inferiorequal_operation = {
    [refines] = {relational_operation},
  }

  inferiorequal_operation[meta][collection].minimum = 2
  inferiorequal_operation[meta][collection].maximum = 2
  inferiorequal_operation[meta][collection].operator = "<="
  
  return inferiorequal_operation
end
