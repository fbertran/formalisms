return function (Layer, npta, ref)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"
  local collection = Layer.require "cosy/formalism/data.collection"

  local boolean_operation = Layer.require "cosy/formalism/operation/boolean"

  local pta = Layer.require "cosy/formalism/automaton/timed/parametric"

  npta [refines] = {
    pta,
  }

  npta.parametric_instances = {
    [refines] = {collection},
    [meta] = {
      [collection] = {
        value_type = pta,
      }
    }
  }
  npta [meta].init_condition_type = boolean_operation

  npta.init_condition = {
    value_type = { ref [meta].parameters_condition_type},
  }

return npta
end