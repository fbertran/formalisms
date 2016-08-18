if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

-- These lines are required to correctly run tests.
require "busted.runner" ()

describe ("Formalism graph.directed", function ()

  it ("can be loaded", function ()
    local Layer = require "layeredata"
    local _     = Layer.require "cosy/formalism/graph.directed"
  end)

  describe ("edges", function ()

    it ("Detects missing source", function ()
      local Layer      = require "layeredata"
      local graph      = Layer.require "cosy/formalism/graph.directed"
      local layer, ref = Layer.new {}

      layer [Layer.key.refines] = { graph }
      
      layer.vertices.a = { id = "a" }
      layer.vertices.b = { id = "b" }
      
      layer.edges.ab  = {
        id = "ab",
        target = layer.vertices.a,
      }
      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("Detects missing target", function ()
      local Layer      = require "layeredata"
      local graph      = Layer.require "cosy/formalism/graph.directed"
      local layer, ref = Layer.new {}

      layer [Layer.key.refines] = { graph }
      
      layer.vertices.a = { id = "a" }
      layer.vertices.b = { id = "b" }
      
      layer.edges.ab  = {
        id = "ab",
        source = layer.vertices.a,
      }

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("Using a good edge", function ()
      local Layer      = require "layeredata"
      local graph      = Layer.require "cosy/formalism/graph.directed"
      local layer, ref = Layer.new {}

      layer [Layer.key.refines] = { graph }
      
      layer.vertices.a = { id = "a" }
      layer.vertices.b = { id = "b" }
      
      layer.edges.ab  = {
        id      = "ab",
        source  = layer.vertices.a,
        target  = layer.vertices.b,
      }
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
    end)



  end)
end)
