-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism data.record", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/data.record"
  end)

  it ("detects missing key (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          record = {
            key = { value_type = "string" },
          },
        },
      },
    }
    Layer.Proxy.check (layer)
    local messages = layer [Layer.key.messages]
    assert.is_not_nil (messages ["cosy/formalism/data.record.value_type.missing"])
  end)

  it ("detects missing key (proxy)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {
      name = "layer",
      data = {
        t = {},
        [Layer.key.labels ] = { layer = true },
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          record = {
            key = { value_type = Layer.reference "layer".t },
          },
        },
      },
    }
    Layer.Proxy.check (layer)
    local messages = layer [Layer.key.messages]
    assert.is_not_nil (messages ["cosy/formalism/data.record.value_type.missing"])
  end)

  it ("detects wrongly typed key/value (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          record = {
            key = { value_type = "string" },
          },
        },
        key = 1,
      },
    }
    Layer.Proxy.check (layer)
    local messages = layer [Layer.key.messages]
    assert.is_not_nil (messages ["cosy/formalism/data.record.value_type.illegal"])
  end)

  it ("detects correctly typed key/value (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          record = {
            key = { value_type = "string" },
          },
        },
        key = "value",
      },
    }
    Layer.Proxy.check (layer)
    assert.is_nil (layer [Layer.key.messages])
  end)

  it ("detects wrongly typed key/value (proxy)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local common = Layer.new {
      name = "record",
      data = {
        type1 = {},
        type2 = {},
        [Layer.key.labels ] = { layer = true },
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          record = {
            key = { value_type = Layer.reference "layer".type1 },
          },
        },
      },
    }
    local l1 = Layer.new {
      name = "l1",
      data = {
        [Layer.key.refines] = { common },
        key = 1,
      }
    }
    local l2 = Layer.new {
      name = "l2",
      data = {
        [Layer.key.refines] = { common },
        key = {
          [Layer.key.refines] = { Layer.reference (false).type2 },
        },
      }
    }
    do
      Layer.Proxy.check (l1)
      local messages = l1 [Layer.key.messages]
      assert.is_not_nil (messages ["cosy/formalism/data.record.value_type.illegal"])
    end
    do
      Layer.Proxy.check (l2)
      local messages = l2 [Layer.key.messages]
      assert.is_not_nil (messages ["cosy/formalism/data.record.value_type.illegal"])
    end
  end)

  it ("detects correctly typed key/value (proxy)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local common = Layer.new {
      name = "record",
      data = {
        type1 = {},
        type2 = {},
        [Layer.key.labels ] = { record = true },
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          record = {
            key = { value_type = Layer.reference "record".type1 },
          },
        },
      },
    }
    local layer = Layer.new {
      name = "layer",
      data = {
        [Layer.key.labels ] = { layer = true },
        [Layer.key.refines] = { common },
        key = {
          [Layer.key.refines] = { Layer.reference "layer".type1 },
        },
      }
    }
    Layer.Proxy.check (layer)
    assert.is_nil (layer [Layer.key.messages])
  end)

  it ("allows non declared keys", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          record = {
            key = { value_type = "string" },
          },
        },
        key = "value",
        zzz = 1,
      },
    }
    Layer.Proxy.check (layer)
    assert.is_nil (layer [Layer.key.messages])
  end)

  it ("forbids non types for value_type", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          record = {
            key = { value_type = true },
          },
        },
        key = true,
      },
    }
    Layer.Proxy.check (layer)
    local messages = layer [Layer.key.messages]
    assert.is_not_nil (messages ["cosy/formalism/data.record.value_type.invalid"])
  end)

end)
