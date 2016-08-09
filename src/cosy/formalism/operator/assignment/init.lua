return function (Layer, assignment_operation)


  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local collection = Layer.require "cosy/formalism/data.collection"


  local binary = Layer.require "cosy/formalism/operator.binary"

  assignment_operation [refines] = {
    binary,
  }

  assignment_operation.operands[meta][collection].minimum = 2
  assignment_operation.operands[meta][collection].maximum = 2
  assignment_operation.operator = "="
  assignment_operation.priority = 10 -- a redefinir

  return assignment_operation
end