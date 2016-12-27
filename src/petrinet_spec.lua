-- These lines are required to correctly run tests.
require "busted.runner" ()

describe ("Formalism petrinet", function ()

  it ("can be loaded", function ()
    local Layer = require "layeredata"
    local _     = Layer.require "petrinet"
  end)

  describe ("places", function ()

    it ("can be created", function ()
      local Layer    = require "layeredata"
      local petrinet = Layer.require "petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a = {}
      layer.places.b = {}
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
      assert.is_true (layer [Layer.key.meta].place_type <= layer.places.a)
      assert.is_true (layer [Layer.key.meta].place_type <= layer.places.b)
    end)

    it ("refine place_type", function ()
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
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
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
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
      local Layer    = require "layeredata"
      local petrinet = Layer.require "petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a = {}
      layer.places.b = {}
      local found = {}
      for k in Layer.pairs (layer.places) do
        found [k] = true
      end
      assert.are.same (found, {
        a = true,
        b = true,
      })
    end)

    it ("are iterable as vertices", function ()
      local Layer    = require "layeredata"
      local petrinet = Layer.require "petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a = {}
      layer.places.b = {}
      local found = {}
      for k in Layer.pairs (layer.vertices) do
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
      local Layer    = require "layeredata"
      local petrinet = Layer.require "petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.transitions.a = {}
      layer.transitions.b = {}
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
      assert.is_true (layer [Layer.key.meta].transition_type <= layer.transitions.a)
      assert.is_true (layer [Layer.key.meta].transition_type <= layer.transitions.b)
    end)

    it ("refine transition_type", function ()
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
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
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
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
      local Layer    = require "layeredata"
      local petrinet = Layer.require "petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.transitions.a = {}
      layer.transitions.b = {}
      local found = {}
      for k in Layer.pairs (layer.transitions) do
        found [k] = true
      end
      assert.are.same (found, {
        a = true,
        b = true,
      })
    end)

    it ("are iterable as vertices", function ()
      local Layer    = require "layeredata"
      local petrinet = Layer.require "petrinet"
      local layer    = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.transitions.a = {}
      layer.transitions.b = {}
      local found = {}
      for k in Layer.pairs (layer.vertices) do
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
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a      = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.places.a,
        target = ref.transitions.b,
      }
      Layer.Proxy.check_all (layer)
      assert.is_nil  (next (Layer.messages))
      assert.is_true (layer [Layer.key.meta].arc_type <= layer.arcs.ab)
      assert.is_true (layer.arcs.ab [Layer.key.meta].arrow_type <= layer.arcs.ab.arrows.source)
      assert.is_true (layer.arcs.ab [Layer.key.meta].arrow_type <= layer.arcs.ab.arrows.target)
    end)

    it ("can be seen as edges", function ()
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a      = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.places.a,
        target = ref.transitions.b,
      }
      Layer.Proxy.check_all (layer)
      assert.is_nil  (next (Layer.messages))
      assert.is_true (layer [Layer.key.meta].edge_type <= layer.edges.ab)
      assert.is_true (layer.edges.ab [Layer.key.meta].arrow_type <= layer.edges.ab.arrows.source)
      assert.is_true (layer.edges.ab [Layer.key.meta].arrow_type <= layer.edges.ab.arrows.target)
    end)

    it ("cannot link two places", function ()
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a    = {}
      layer.places.b    = {}
      layer.pre_arcs.ab = {
        source = ref.places.a,
        target = ref.places.b,
      }
      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("cannot link two transitions", function ()
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.transitions.a = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.transitions.a,
        target = ref.transitions.b,
      }
      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("are iterable", function ()
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a      = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.places.a,
        target = ref.transitions.b,
      }
      local found = {}
      for k in Layer.pairs (layer.arcs) do
        found [k] = true
      end
      assert.are.same (found, {
        ab = true,
      })
    end)

    it ("are iterable as vertices", function ()
      local Layer      = require "layeredata"
      local petrinet   = Layer.require "petrinet"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { petrinet }
      layer.places.a      = {}
      layer.transitions.b = {}
      layer.pre_arcs.ab   = {
        source = ref.places.a,
        target = ref.transitions.b,
      }
      local found = {}
      for k in Layer.pairs (layer.edges) do
        found [k] = true
      end
      assert.are.same (found, {
        ab = true,
      })
    end)

  end)


end)
