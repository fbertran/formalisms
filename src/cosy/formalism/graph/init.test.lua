-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism graph", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/graph"
  end)

  it ("allows to create vertices", function ()
    local graph = Layer.require "cosy/formalism/graph"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { graph },
      },
    }
    layer.vertices.a = {}
    layer.vertices.b = {}
    Layer.Proxy.check (layer)
    assert.is_nil (layer [Layer.key.messages])
    assert.is_true (layer [Layer.key.meta].vertex_type <= layer.vertices.a)
    assert.is_true (layer [Layer.key.meta].vertex_type <= layer.vertices.b)
  end)

  it ("does not add refinement if a vertex already refines something", function ()
    local graph = Layer.require "cosy/formalism/graph"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { graph },
        [Layer.key.meta   ] = {
          t = {},
        },
      },
    }
    layer.vertices.a = {
      [Layer.key.refines] = { Layer.reference (false) [Layer.key.meta].t }
    }
    assert.is_true  (layer [Layer.key.meta].t <= layer.vertices.a)
    assert.is_false (layer [Layer.key.meta].vertex_type <= layer.vertices.a)
  end)

  it ("allows to iterate over vertices", function ()
    local graph = Layer.require "cosy/formalism/graph"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { graph },
      },
    }
    layer.vertices.a = {}
    layer.vertices.b = {}
    local found = {}
    for k in pairs (layer.vertices) do
      found [k] = true
    end
    assert.are.same (found, {
      a = true,
      b = true,
    })
  end)

end)
