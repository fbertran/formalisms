-- Assignment Operator
-- Here pri-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, assignment)

  local refines = Layer.key.refines
  local binary  = Layer.require "cosy/formalism/operator.binary"
  local assignment_operation = Layer.require "cosy/formalism/operation/assignment"
  
  assignment [refines] = {
    assignment_operation,
    binary,
  }

  assignment .operator = "="
  assignment .priority = 1

end