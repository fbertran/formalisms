-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism operation.operation", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/operation"
  end)

  describe ("with type information", function ()

    it ("forbids a different type for operator", function ()
      local operation = Layer.require "cosy/formalism/operation"
      local refines =  Layer.key.refines
      local value_string= Layer.require "cosy/formalism/literal.string"

      local operator     = Layer.new {
        name = "operator",
        data= {
          [refines] = { value_string },
           value="AND"
          }
         }
   
        
      local val_test1     = Layer.new {
        name = "val_test1",
        data= {
          [refines] = { value_string, },
           value="testvalue1"
          }
         }
      local val_test2     = Layer.new {
        name = "val_test2",
        data= {
          [refines] = { value_string, },
           value="testvalue2"
          }
         }
         
      local layer      = Layer.new {
        name = "layer",
        data= {
          [refines] = { operation },
           operator=operator,
           operands={
            op1=val_test1,
            op2=val_test2,
          }
         }
        }

      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)
