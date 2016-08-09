--NOT Operation

return function (Layer, not_operation)

  local refines    =  Layer.key.refines


  
  local prefix = Layer.require "cosy/formalism/operator/unary.prefix"

  not_operation [refines] = {
    prefix
  }

  not_operation.operator = "~"
  not_operation.priority = 14

  return not_operation
end
