if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism data.record", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/data.record"
  end)

  it ("detects missing key (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { record }
    layer [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = "string" },
      },
    }
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

  it ("detects missing key (proxy)", function ()
    local record     = Layer.require "cosy/formalism/data.record"
    local layer, ref = Layer.new {}
    layer.t = {}
    layer [Layer.key.refines] = { record }
    layer [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = ref.t },
      },
    }
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

  it ("detects wrongly typed key/value (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { record }
    layer [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = "boolean" },
      },
    }
    layer.key = 1
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

  it ("detects correctly typed key/value (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { record }
    layer [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = "string" },
      },
    }
    layer.key = "value"
    Layer.Proxy.check (layer)
    assert.is_nil (Layer.messages (layer) ())
  end)


  it ("detects correctly typed key/value (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { record }
    layer [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = "string",},
      },
    }
    layer.key = "ok"
    Layer.Proxy.check (layer)
    assert.is_nil (Layer.messages (layer) ())
  end)

  it ("detects wrongly typed key/value (proxy)", function ()
    local record     = Layer.require "cosy/formalism/data.record"
    local common, rc = Layer.new {}
    common.type1 = {}
    common.type2 = {}
    common [Layer.key.refines] = { record }
    common [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = rc.type1 },
      },
    }
    local l1 = Layer.new {}
    l1 [Layer.key.refines] = { common }
    l1.key = 1
    local l2, rl2 = Layer.new {}
    l2 [Layer.key.refines] = { common }
    l2.key = {
      [Layer.key.refines] = { rl2.type2 },
    }
    do
      Layer.Proxy.check (l1)
      assert.is_not_nil (Layer.messages (l1) ())
    end
    do
      Layer.Proxy.check (l2)
      assert.is_not_nil (Layer.messages (l2) ())
    end
  end)

  it ("detects correctly typed key/value (proxy)", function ()
    local record     = Layer.require "cosy/formalism/data.record"
    local common, rc = Layer.new {}
    common.type1 = {}
    common.type2 = {}
    common [Layer.key.refines] = { record }
    common [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = rc.type1 },
      },
    }
    local layer, ref = Layer.new {}
    layer [Layer.key.refines] = { common }
    layer.key = {
      [Layer.key.refines] = { ref.type1 },
    }
    Layer.Proxy.check (layer)
    assert.is_nil (Layer.messages (layer) ())
  end)

  it ("allows non declared keys", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { record }
    layer [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = "string" },
      },
    }
    layer.key = "value"
    layer.zzz = 1
    Layer.Proxy.check (layer)
    assert.is_nil (Layer.messages (layer) ())
  end)

  it ("forbids non types for value_type", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { record }
    layer [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = true },
      },
    }
    layer.key = true
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

end)
