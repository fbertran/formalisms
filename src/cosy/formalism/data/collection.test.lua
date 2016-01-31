-- These lines are required to correctly run tests:
require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism data.collection", function ()

  it ("can be loaded", function ()
    local _ = require "cosy.formalism.data.collection"
  end)

  describe ("with key_type", function ()

    it ("allows an empty collection", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              key_type = "string" ,
            },
          },
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("allows anything if key_type is not defined", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {},
          },
          [true] = true,
          [1   ] = 1,
          key    = "value",
          [Layer.reference (false)] = Layer.reference (false),
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("detects wrongly typed key (primitive)", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              key_type = "string",
            },
          },
          [true] = true,
        },
      }
      Layer.Proxy.check (layer)
      local messages = layer [Layer.key.messages]
      assert.is_not_nil (messages ["formalism:data:collection:key_type:illegal"])
    end)

    it ("detects correctly typed key (primitive)", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              key_type = "string",
            },
          },
          key = "value",
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("detects wrongly typed key (reference)", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            t1 = {},
            t2 = {},
            collection = {
              key_type = Layer.reference (false) [Layer.key.meta].t1,
            },
          },
          [Layer.reference (false) [Layer.key.meta].t2] = true,
        },
      }
      Layer.Proxy.check (layer)
      local messages = layer [Layer.key.messages]
      assert.is_not_nil (messages ["formalism:data:collection:key_type:illegal"])
    end)

    it ("detects correctly typed key (reference)", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer  = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            t1 = {},
            t2 = {},
            collection = {
              key_type = Layer.reference (false) [Layer.key.meta].t1,
            },
          },
          [Layer.reference (false) [Layer.key.meta].t1] = true,
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("detects misreferenced key", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer  = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            t1 = {},
            collection = {
              key_type = Layer.reference (false) [Layer.key.meta].t1,
            },
          },
          [Layer.reference (false).t1] = true,
        },
      }
      Layer.Proxy.check (layer)
      local messages = layer [Layer.key.messages]
      assert.is_not_nil (messages ["formalism:data:collection:key_type:missing"])
    end)

    it ("forbids other types for key_type", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer  = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              key_type = true,
            },
          },
        },
      }
      Layer.Proxy.check (layer)
      local messages = layer [Layer.key.messages]
      assert.is_not_nil (messages ["formalism:data:collection:key_type:invalid"])
    end)

  end)

  describe ("with value_type", function ()

    it ("allows an empty collection", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              value_type = "string" ,
            },
          },
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("allows anything if value_type is not defined", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {},
          },
          [true] = true,
          [1   ] = 1,
          key    = "value",
          [Layer.reference (false)] = Layer.reference (false),
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("detects wrongly typed value (primitive)", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              value_type = "string",
            },
          },
          key = true,
        },
      }
      Layer.Proxy.check (layer)
      local messages = layer [Layer.key.messages]
      assert.is_not_nil (messages ["formalism:data:collection:value_type:illegal"])
    end)

    it ("detects correctly typed value (primitive)", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              key_type = "string",
            },
          },
          key = "value",
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("detects wrongly typed value (proxy)", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            t1 = {},
            t2 = {},
            collection = {
              value_type = Layer.reference (false) [Layer.key.meta].t1,
            },
          },
          key = {
            [Layer.key.refines] = { Layer.reference (false) [Layer.key.meta].t2 }
          },
        },
      }
      Layer.Proxy.check (layer)
      local messages = layer [Layer.key.messages]
      assert.is_not_nil (messages ["formalism:data:collection:value_type:illegal"])
    end)

    it ("detects correctly typed value (proxy) #current", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer  = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            t1 = {},
            t2 = {},
            collection = {
              value_type = Layer.reference (false) [Layer.key.meta].t1,
            },
          },
          key = {
            [Layer.key.refines] = { Layer.reference (false) [Layer.key.meta].t1 }
          },
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("cannot detect misreferenced value", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer  = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            t1 = {},
            collection = {
              value_type = Layer.reference (false) [Layer.key.meta].t1,
            },
          },
          key = Layer.reference (false) [Layer.key.meta].t2,
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (layer [Layer.key.messages])
    end)

    it ("forbids other types for value_type", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer  = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              value_type = true,
            },
          },
        },
      }
      Layer.Proxy.check (layer)
      local messages = layer [Layer.key.messages]
      assert.is_not_nil (messages ["formalism:data:collection:value_type:invalid"])
    end)

  end)

end)
