local Serpent           = require "serpent"
local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new { 
  name = "hyper & multi graph instance" 
}
local _                 = Layer.reference "HMGT_model"

layer.__depends__ = {
  hyper_multi_graph,
}

layer.__label__ = "HMGT_model"

layer.model = {
  __refines__ = {
    _.__meta__.hyper_multi_graph_type,
  },

  vertices = {
    n1 = {},
    n2 = {},
    n3 = {},
  },
  
  edges = {
    e1 = {
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
        },
        [2] = {
          vertex = _.model.vertices.n2,
        },
        [3] = {
          vertex = _.model.vertices.n3,
        },
      },
    },
    
    e2 = {
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
        },
        [2] = {
          vertex = _.model.vertices.n2,
        },
      },
    },
  },
}


local function dump (x)
  return Serpent.dump (x, {
    indent   = "  ",
    comment  = false,
    sortkeys = true,
    compact  = false,
  })
end

do
--  local checks_edges = _.__meta__.edge_type.__meta__.checks

--  for i = 1, Layer.size (checks_edges) do
--    checks_edges [i] [nil] (layer.model.edges)
--  end
--  
  print(dump(Layer.flatten(layer)))
end
