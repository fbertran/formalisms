--Addition Operation

return function (Layer, addnary_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection =  Layer.require "cosy/formalism/data.collection"
  local prefix = Layer.require "cosy/formalism/operator/nary.prefix"
  
  addnary_operation [refines] = {
     prefix
  }

  addnary_operation.operands[meta][collection].minimum = 2
  addnary_operation.operands[meta][collection].maximum = math.huge
  addnary_operation.operator = "+"
  addnary_operation.priority = 13
 
  
  return addnary_operation
end
