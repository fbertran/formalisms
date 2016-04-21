--Superior Operation

return function (Layer, superior_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/relational_operation"

  superior_operation = {
    [refines] = {relational_operation},
  }

  superior_operation[meta][collection].minimum = 2
  superior_operation[meta][collection].maximum = 2
  superior_operation[meta][collection].operator = ">"
  
  return superior_operation
end
