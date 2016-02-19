-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism data.enumeration", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/data.enumeration"
  end)

  it ("detects wrongly typed elements (primitive)", function ()
    local enumeration = Layer.require "cosy/formalism/data.enumeration"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { enumeration },
        [Layer.key.meta   ] = {
          [enumeration] = {
            symbol_type = "string"
          },
        },
        key = 3,
      },
    }
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

  it ("detects correctly typed elements (primitive)", function ()
    local enumeration = Layer.require "cosy/formalism/data.enumeration"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { enumeration },
        [Layer.key.meta   ] = {
          [enumeration] = {
            symbol_type = "string"
          },
        },
        key = "value",
      },
    }
    Layer.Proxy.check (layer)
    assert.is_nil (Layer.messages (layer) ())
  end)

  it ("detects wrongly typed elements (proxy)", function ()
    local enumeration = Layer.require "cosy/formalism/data.enumeration"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.labels ] = { label = true },
        [Layer.key.refines] = { enumeration },
        [Layer.key.meta   ] = {
          t = {},
          [enumeration] = {
            symbol_type = Layer.reference "label" [Layer.key.meta].t,
          }
        },
        key = true,
      },
    }
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

  it ("detects correctly typed elements (proxy)", function ()
    local enumeration = Layer.require "cosy/formalism/data.enumeration"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.labels ] = { label = true },
        [Layer.key.refines] = { enumeration },
        [Layer.key.meta   ] = {
          t = {},
          [enumeration] = {
            symbol_type = Layer.reference "label" [Layer.key.meta].t,
          }
        },
        key = {
          [Layer.key.refines] = { Layer.reference "label" [Layer.key.meta].t }
        },
      },
    }
    Layer.Proxy.check (layer)
    assert.is_nil (Layer.messages (layer) ())
  end)

  it ("sets the value type by default (proxy)", function ()
    local enumeration = Layer.require "cosy/formalism/data.enumeration"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.labels ] = { label = true },
        [Layer.key.refines] = { enumeration },
        [Layer.key.meta   ] = {
          t = { a = 1 },
          [enumeration] = {
            symbol_type = Layer.reference "label" [Layer.key.meta].t,
          }
        },
        key = {},
      },
    }
   Layer.Proxy.check (layer)
   assert.is_nil (Layer.messages (layer) ())
  end)

end)
