return function (Layer, assignment_operation)

  local refines = Layer.key.refines

  local operation = Layer.require "cosy/formalism/operation"

  assignment_operation [refines] = {
    operation,
  } 
  
end