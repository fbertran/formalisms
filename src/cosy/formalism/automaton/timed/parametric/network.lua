return function (Layer, npta)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local collection = Layer.require "cosy/formalism/data.collection"



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


return npta
end