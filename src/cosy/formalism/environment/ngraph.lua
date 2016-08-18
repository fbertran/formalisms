return function (Layer, ngraph)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local environment = Layer.require "cosy/formalism/environment"

  local graph = Layer.require "cosy/formalism/graph"

  local collection = Layer.require "cosy/formalism/data.collection"
  local record = Layer.require "cosy/formalism/data.record"

  ngraph [refines] = {
    environment,
  }
  ngraph.container [meta][collection].value_type = graph

  ngraph.shared [meta][record] = {
    vertices = {
      [refines] = {collection},
      [meta] = {
        [collection] = {
          value_type = graph [meta].vertex_type,
        }
      }
    }
    
  }


return ngraph
end