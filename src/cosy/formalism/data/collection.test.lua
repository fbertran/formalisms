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
      local layer  = Layer.new {
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
      local messages = layer [Layer.key.messages]
      assert.is_nil (messages)
    end)

    it ("allows anything if key_type is not defined", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer  = Layer.new {
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
      local messages = layer [Layer.key.messages]
      assert.is_nil (messages)
    end)

    it ("detects wrongly typed key (primitive)", function ()
      local Collection = require "cosy.formalism.data.collection"
      local layer  = Layer.new {
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
      local layer  = Layer.new {
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

    it ("does not allow proxy for key_type", function ()
      local Collection = require "cosy.formalism.data.collection"
      local collection = Layer.new {
        name = "collection",
        data = {
          type1 = {},
          type2 = {},
          [Layer.key.labels ] = { layer = true },
          [Layer.key.refines] = { Collection },
          [Layer.key.meta   ] = {
            collection = {
              key_type = Layer.reference "layer".type1,
            },
          },
        },
      }
      Layer.Proxy.check (collection)
      local messages = collection [Layer.key.messages]
      assert.is_not_nil (messages ["formalism:data:collection:key_type:not-primitive"])
    end)

  end)

end)
