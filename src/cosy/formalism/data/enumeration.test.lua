-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "layeredata"
do
  local oldrequire = Layer.require
  Layer.require = function (name)
    return oldrequire (name:gsub ("/", "."))
  end
end

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
          symbol_type = "string"
        },
        key = 3,
      },
    }
    Layer.Proxy.check (layer)
    local messages = layer [Layer.key.messages]
    assert.is_not_nil (messages ["cosy/formalism/data.collection.value_type.illegal"])
  end)

  it ("detects correctly typed elements (primitive)", function ()
    local enumeration = Layer.require "cosy/formalism/data.enumeration"
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { enumeration },
        [Layer.key.meta   ] = {
          symbol_type = "string"
        },
        key = "value",
      },
    }
    Layer.Proxy.check (layer)
    assert.is_nil (layer [Layer.key.messages])
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
          symbol_type = Layer.reference "label" [Layer.key.meta].t,
        },
        key = true,
      },
    }
    Layer.Proxy.check (layer)
    local messages = layer [Layer.key.messages]
    assert.is_not_nil (messages ["cosy/formalism/data.collection.value_type.illegal"])
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
          symbol_type = Layer.reference "label" [Layer.key.meta].t,
        },
        key = {
          [Layer.key.refines] = { Layer.reference "label" [Layer.key.meta].t }
        },
      },
    }
    Layer.Proxy.check (layer)
    assert.is_nil (layer [Layer.key.messages])
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
          symbol_type = Layer.reference "label" [Layer.key.meta].t,
        },
        key = {},
      },
    }
   Layer.Proxy.check (layer)
   assert.is_nil (layer [Layer.key.messages])
  end)

end)
