-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism operation.operation", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/expression"
  end)

  describe ("with type information", function ()

    it ("forbids a different type for operator", function ()
      local expression = Layer.require "cosy/formalism/expression"  
      local refines =  Layer.key.refines
      local operation = Layer.require "cosy/formalism/operation"
      local val_string = Layer.require "cosy/formalism/literal.string"
      local val_number = Layer.require "cosy/formalism/literal.number"
      val_string.value="op"
      val_number.value=1
      operation.minimum=val_number
      operation.maximum=val_number
      operation.operator=val_string
      local layer      = Layer.new {
        name = "layer",
        data= {
          [refines] = { expression },
           op1=operation
          
         }
        }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)
