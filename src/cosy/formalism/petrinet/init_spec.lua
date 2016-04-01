-- These lines are required to correctly run tests.
require "busted.runner" ()

-- collectgarbage ("setpause", 1000)
local Layer = require "cosy.formalism.layer"

describe ("Formalism petrinet", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/petrinet"
  end)

  describe ("places", function ()

    it ("can be created", function ()
      local petrinet = Layer.require "cosy/formalism/petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a = {}
      layer.places.b = {}
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
      assert.is_true (layer [Layer.key.meta].place_type <= layer.places.a)
      assert.is_true (layer [Layer.key.meta].place_type <= layer.places.b)
    end)

    it ("refine place_type", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer [Layer.key.meta   ] = {
        t = {},
      }
      layer.places.a = {
        [Layer.key.refines] = { ref [Layer.key.meta].t }
      }
      assert.is_true (layer [Layer.key.meta].t <= layer.places.a)
      assert.is_true (layer [Layer.key.meta].place_type <= layer.places.a)
    end)

    it ("refine vertex_type", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer [Layer.key.meta   ] = {
        t = {},
      }
      layer.places.a = {
        [Layer.key.refines] = { ref [Layer.key.meta].t }
      }
      assert.is_true (layer [Layer.key.meta].t <= layer.vertices.a)
      assert.is_true (layer [Layer.key.meta].vertex_type <= layer.vertices.a)
    end)

    it ("are iterable", function ()
      local petrinet = Layer.require "cosy/formalism/petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a = {}
      layer.places.b = {}
      local found = {}
      for k in pairs (layer.places) do
        found [k] = true
      end
      assert.are.same (found, {
        a = true,
        b = true,
      })
    end)

    it ("are iterable as vertices", function ()
      local petrinet = Layer.require "cosy/formalism/petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a = {}
      layer.places.b = {}
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

  describe ("transitions", function ()

    it ("can be created", function ()
      local petrinet = Layer.require "cosy/formalism/petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.transitions.a = {}
      layer.transitions.b = {}
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
      assert.is_true (layer [Layer.key.meta].transition_type <= layer.transitions.a)
      assert.is_true (layer [Layer.key.meta].transition_type <= layer.transitions.b)
    end)

    it ("refine transition_type", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer [Layer.key.meta   ] = {
        t = {},
      }
      layer.transitions.a = {
        [Layer.key.refines] = { ref [Layer.key.meta].t }
      }
      assert.is_true (layer [Layer.key.meta].t <= layer.transitions.a)
      assert.is_true (layer [Layer.key.meta].transition_type <= layer.transitions.a)
    end)

    it ("refine vertex_type", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer [Layer.key.meta   ] = {
        t = {},
      }
      layer.transitions.a = {
        [Layer.key.refines] = { ref [Layer.key.meta].t }
      }
      assert.is_true (layer [Layer.key.meta].t <= layer.vertices.a)
      assert.is_true (layer [Layer.key.meta].vertex_type <= layer.vertices.a)
    end)

    it ("are iterable", function ()
      local petrinet = Layer.require "cosy/formalism/petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.transitions.a = {}
      layer.transitions.b = {}
      local found = {}
      for k in pairs (layer.transitions) do
        found [k] = true
      end
      assert.are.same (found, {
        a = true,
        b = true,
      })
    end)

    it ("are iterable as vertices", function ()
      local petrinet = Layer.require "cosy/formalism/petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.transitions.a = {}
      layer.transitions.b = {}
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

  describe ("arcs", function ()

    it ("can be created", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a      = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.places.a,
        target = ref.transitions.b,
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
      assert.is_true (layer [Layer.key.meta].arc_type <= layer.arcs.ab)
      assert.is_true (layer.arcs.ab [Layer.key.meta].arrow_type <= layer.arcs.ab.arrows.source)
      assert.is_true (layer.arcs.ab [Layer.key.meta].arrow_type <= layer.arcs.ab.arrows.target)
    end)

    it ("can be seen as edges #current", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a      = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.places.a,
        target = ref.transitions.b,
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
      assert.is_true (layer [Layer.key.meta].edge_type <= layer.edges.ab)
      assert.is_true (layer.edges.ab [Layer.key.meta].arrow_type <= layer.edges.ab.arrows.source)
      assert.is_true (layer.edges.ab [Layer.key.meta].arrow_type <= layer.edges.ab.arrows.target)
    end)

    it ("cannot link two places", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a    = {}
      layer.places.b    = {}
      layer.pre_arcs.ab = {
        source = ref.places.a,
        target = ref.places.b,
      }
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("cannot link two transitions", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.transitions.a = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.transitions.a,
        target = ref.transitions.b,
      }
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("are iterable", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a      = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.places.a,
        target = ref.transitions.b,
      }
      local found = {}
      for k in pairs (layer.arcs) do
        found [k] = true
      end
      assert.are.same (found, {
        ab = true,
      })
    end)

    it ("are iterable as vertices", function ()
      local petrinet   = Layer.require "cosy/formalism/petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a      = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.places.a,
        target = ref.transitions.b,
      }
      local found = {}
      for k in pairs (layer.edges) do
        found [k] = true
      end
      assert.are.same (found, {
        ab = true,
      })
    end)

  end)


end)
