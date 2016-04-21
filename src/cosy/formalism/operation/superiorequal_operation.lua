--SuperiorEqual Operation

return function (Layer, superiorequal_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/relational_operation"

  superiorequal_operation = {
    [refines] = {relational_operation},
  }

  superiorequal_operation[meta][collection].minimum = 2
  superiorequal_operation[meta][collection].maximum = 2
  superiorequal_operation[meta][collection].operator = ">="
  
  return superiorequal_operation
end
