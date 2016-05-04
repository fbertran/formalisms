if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism data.collection", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/data.collection"
  end)

  describe ("with size information", function ()

    it ("forbids a size less than the minimum", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          minimum = 1,
        },
      }
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("allows any size if there is no minimum", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {},
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("forbids a size greater than the maximum", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          maximum = 1,
        },
      }
      layer.a = true
      layer.b = true
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("allows any size if there is no maximum", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {},
      }
      layer.a = true
      layer.b = true
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

  end)

  describe ("with key_type", function ()

    it ("allows an empty collection", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          key_type = "string",
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("allows anything if key_type is not defined", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {},
      }
      layer [true] = true
      layer [1   ] = 1
      layer.key    = "value"
      layer [ref] = ref
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("detects wrongly typed key (primitive)", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          key_type = "string",
        },
      }
      layer [true] = true
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("detects correctly typed key (primitive)", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          key_type = "string",
        },
      }
      layer.key = "value"
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("detects wrongly typed key (reference)", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        t1 = {},
        t2 = {},
        [collection] = {
          key_type = ref [Layer.key.meta].t1,
        },
      }
      layer [ref [Layer.key.meta].t2] = true
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("detects correctly typed key (reference)", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        t1 = {},
        t2 = {},
        [collection] = {
          key_type = ref [Layer.key.meta].t1,
        },
      }
      layer [ref [Layer.key.meta].t1] = true
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("detects misreferenced key", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        t1 = {},
        [collection] = {
          key_type = ref [Layer.key.meta].t1,
        },
      }
      layer [ref.t1] = true
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("forbids other types for key_type", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer  = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          key_type = true,
        },
      }
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

  end)

  describe ("with value_type", function ()

    it ("allows an empty collection", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          value_type = "string" ,
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("allows anything if value_type is not defined", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {},
      }
      layer [true] = true
      layer [1   ] = 1
      layer.key    = "value"
      layer [ref] = ref
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("detects wrongly typed value (primitive)", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          value_type = "string",
        },
      }
      layer.key = 42
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("detects correctly typed value (primitive)", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          key_type = "string",
        },
      }
      layer.key = "value"
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("automatically adds value_type (proxy)", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        t1 = {},
        t2 = {},
        [collection] = {
          value_type = ref [Layer.key.meta].t1,
        },
      }
      layer.key = {
        [Layer.key.refines] = { ref [Layer.key.meta].t2 }
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("detects correctly typed value (proxy)", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        t1 = {},
        t2 = {},
        [collection] = {
          value_type = ref [Layer.key.meta].t1,
        },
      }
      layer.key = {
        [Layer.key.refines] = { ref [Layer.key.meta].t1 }
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("cannot detect misreferenced value", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer, ref = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        t1 = {},
        [collection] = {
          value_type = ref [Layer.key.meta].t1,
        },
      }
      layer.key = ref [Layer.key.meta].t2
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("forbids other types for value_type", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer  = Layer.new {}
      layer [Layer.key.refines] = { collection }
      layer [Layer.key.meta   ] = {
        [collection] = {
          value_type = true,
        },
      }
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)


    it ("forbids other types for value_type", function ()

      local collection = Layer.require "cosy/formalism/data.collection"
      local record = Layer.require "cosy/formalism/data.record"
			local meta   = Layer.key.meta
      local layer,ref  = Layer.new {}
      layer [Layer.key.refines] = { collection }
			
      layer [Layer.key.meta   ] = {

				my_type = {
					[Layer.key.refines] = { record },
					[meta] = {
						[record] = {
							value = {value_type = "string"}
						}				
					},
				},
	    	[collection] = {
	        value_type = ref[meta].my_type,
	      },
      }
		
			layer.op = {
				[Layer.key.refines] = {ref[meta].my_type},
				value = "lol"
			}

      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
  end)

end)
