if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

-- These lines are required to correctly run tests.
require "busted.runner" ()

describe ("Formalism graph.binary_edges", function ()

  it ("can be loaded", function ()
    local Layer = require "layeredata"
    local _     = Layer.require "cosy/formalism/graph.binary_edges"
  end)

  describe ("edges", function ()

    it ("forbids less than 2 arrows (vertices pointed) by an edge", function ()
      local Layer      = require "layeredata"
      local graph      = Layer.require "cosy/formalism/graph.binary_edges"
      local layer, ref = Layer.new {}

      layer [Layer.key.refines] = { graph }
      
      layer.vertices.a = { id = "a" }
      
      layer.edges.a   = {
        arrows = {
          a = { vertex = ref.vertices.a },
        },
        id = "a",
      }
      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))

    end)

    it ("forbids more than 2 arrows (vertices pointed) by an edge", function ()
      local Layer      = require "layeredata"
      local graph      = Layer.require "cosy/formalism/graph.binary_edges"
      local layer, ref = Layer.new {}

      layer [Layer.key.refines] = { graph }
      
      layer.vertices.a = { id = "a" }
      layer.vertices.b = { id = "b" }
      layer.vertices.c = { id = "c" }
      
      layer.edges.abc   = {
        arrows = {
          { vertex = ref.vertices.a },
          { vertex = ref.vertices.b },
          { vertex = ref.vertices.c },
        },
        id = "abc",
      }
      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("using 2 arrows (vertices pointed) by an edge", function ()
      local Layer      = require "layeredata"
      local graph      = Layer.require "cosy/formalism/graph.binary_edges"
      local layer, ref = Layer.new {}

      layer [Layer.key.refines] = { graph }
      
      layer.vertices.a = { id = "a" }
      layer.vertices.b = { id = "b" }
      layer.vertices.c = { id = "c" }
      
      layer.edges.ab  = {
        arrows = {
          { vertex = ref.vertices.a },
          { vertex = ref.vertices.b }, 
        },
        id = "ab",
      }
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
    end)

  end)
end)
