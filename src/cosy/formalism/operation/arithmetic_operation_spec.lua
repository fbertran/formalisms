--[[ These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism operation.arithmetic_operation", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/operation.arithmetic_operation"
  end)

  describe ("with type information", function ()

    it ("forbids a different type for operator", function ()
      local arithmetic_operation = Layer.require "cosy/formalism/operation.arithmetic_operation"  
      local refines =  Layer.key.refines
      local val_test = Layer.require "cosy/formalism/literal.string"
      local val_testn = Layer.require "cosy/formalism/literal.number"
      val_test.value="op"
      val_testn.value=1
      local layer      = Layer.new {
        name = "layer",
        data= {
          [refines] = { arithmetic_operation },
           operator=val_test,
           minimum=val_testn,
           maximum=val_testn,
           operands={
            val_test,
          }
         }
        }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
  end)

  describe ("with number of operands", function ()

    it ("forbids a different type for operator", function ()
      local arithmetic_operation = Layer.require "cosy/formalism/operation.arithmetic_operation"  
      local refines =  Layer.key.refines
      local val_test = Layer.require "cosy/formalism/literal.string"
      local val_min = Layer.require "cosy/formalism/literal.number"
      local val_max = Layer.require "cosy/formalism/literal.number"
      val_test.value="op"
      val_min.value=2
      val_max.value=1
      local layer      = Layer.new {
        name = "layer",
        data= {
          [refines] = { arithmetic_operation },
           operator=val_test,
           minimum=val_min,
           maximum=val_max,
           operands={
            val_test,
          }
         }
        }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
  end)

end)]]--
