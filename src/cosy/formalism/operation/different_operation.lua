--Different Operation

return function (Layer, different_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/relational_operation"

  different_operation = {
    [refines] = {relational_operation},
  }

  different_operation[meta][collection].minimum = 2
  different_operation[meta][collection].maximum = 2
  different_operation[meta][collection].operator = "~="
  
  return different_operation
end
