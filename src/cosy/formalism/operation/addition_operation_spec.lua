-- These lines are required to correctly run tests.

if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()


local Layer = require "layeredata"

describe ("Formalism operation.addition", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/operation.addition_operation"
  end)
  describe ("type of information", function ()
    it ("operands_type", function()
      local number = Layer.require "cosy/formalism/literal.number"
      local addition_operation = Layer.require "cosy/formalism/operation.addition_operation"
      local record = Layer.require "cosy/formalism/data.record"
      local layer = Layer.new {}
      local nb1 = Layer.new {}
      local nb2 = Layer.new {}
      nb1 [Layer.key.refines] = {number}
      nb2 [Layer.key.refines] = {number}
      layer [Layer.key.refines] = {addition_operation}
      layer [Layer.key.meta][record].operands_type = number 
      layer.operands = {
        nb1,
        nb2
      }

      Layer.Proxy.check_all(layer)
      assert.is_nil( next ( Layer.messages ) )


    end)
  
  end)

end)
