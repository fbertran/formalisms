require "busted.runner" ()

local Layer = require "layeredata"
local refines = Layer.key.refines

describe ("Formalism expression", function ()
  describe ("expression", function ()
    it ("has the right operator min - max", function ()
      local layer = Layer.new {}
      local expression = Layer.require "expression"
      local addition_op = Layer.require "operator.addition"

      layer [refines] = { expression }
      layer.operator = addition_op

      -- fails because only one operand
      layer.operands = {
        10,
      }

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)
  end)
end)
