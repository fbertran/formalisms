--[[ These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism operation.logical_operation", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/automaton/timed_automaton/operation.logical_operation"
  end)

  describe ("with type information", function ()

    it ("forbids a different type for operator", function ()
      local logical_operation = Layer.require "cosy/formalism/automaton/timed_automaton/operation.logical_operation"  
      local refines =  Layer.key.refines
      local val_test = Layer.require "cosy/formalism/literal.string"
      local val_testn = Layer.require "cosy/formalism/literal.number"
      val_test.value="op"
      val_testn.value=1
      local layer      = Layer.new {
        name = "layer",
        data= {
          [refines] = { logical_operation },
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

end)]]--
