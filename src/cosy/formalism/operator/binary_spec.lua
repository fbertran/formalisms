--These lines are required to correctly run tests.
if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end
require "busted.runner" ()

local Layer   = require "layeredata"
local refines = Layer.key.refines
local meta    = Layer.key.meta

describe ("Formalism binary", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/operator.binary"
  end)

  describe ("with number of operands", function ()

    it ("use good number of operands (2 operands)", function ()
      local binary_operator  = Layer.require "cosy/formalism/operator.binary"
      local number         = Layer.require "cosy/formalism/literal.number"
      local op1, op2, layer

      layer = Layer.new { name = "layer" }
      op1 = Layer.new { name = "op1" }
      op2 = Layer.new { name = "op2" }

      layer [refines] = {binary_operator}
      op1 [refines] = {number}
      op2 [refines] = {number}

      op1 .value = 12
      op2 .value = 16


      layer .operator = ""
      layer .priority = 1
      layer [meta] .operands_type = number

      layer .operands [1] = op1
      layer .operands [2] = op2
      
      Layer.Proxy.check_all (layer)

      assert.is_nil (next (Layer.messages))
    end)

    it ("forbids more than 2 operands", function ()
      local binary_operator  = Layer.require "cosy/formalism/operator.binary"
      local number         = Layer.require "cosy/formalism/literal.number"
      local op1, op2, op3, layer

      layer = Layer.new { name = "layer" }
      op1 = Layer.new { name = "op1" }
      op2 = Layer.new { name = "op2" }
      op3 = Layer.new { name = "op3" }

      layer [refines] = {binary_operator}
      op1 [refines] = {number}
      op2 [refines] = {number}
      op3 [refines] = {number}

      op1 .value = 12
      op2 .value = 16
      op3 .value = 19


      layer .operator = ""
      layer .priority = 1
      layer [meta] .operands_type = number

      layer .operands [1] = op1
      layer .operands [2] = op2
      layer .operands [3] = op3
      

      Layer.Proxy.check_all (layer)

      assert.is_not_nil (next (Layer.messages))
    end)
  end)

  describe ("with type of operands", function ()

    it ("forbids diffrent type of operands (proxy)", function ()
      local binary_operator  = Layer.require "cosy/formalism/operator.binary"
      local number         = Layer.require "cosy/formalism/literal.number"
      local op1, op2, layer

      layer = Layer.new { name = "layer" }
      op1 = Layer.new { name = "op1" }
      op2 = Layer.new { name = "op2" }

      layer [refines] = {binary_operator}
      op1 [refines] = {number}

      op1 .value = 12


      layer .operator = ""
      layer .priority = 1
      layer [meta] .operands_type = number

      layer .operands [1] = op1
      layer .operands [2] = op2
      

      Layer.Proxy.check_all (layer)

      assert.is_not_nil (next (Layer.messages))
    end)

    it ("forbids diffrent type of operands (primitive)", function ()
      local binary_operator  = Layer.require "cosy/formalism/operator.binary"
      local number         = Layer.require "cosy/formalism/literal.number"
      local op1, op2, layer

      layer = Layer.new { name = "layer" }
      op1 = Layer.new { name = "op1" }


      layer [refines] = {binary_operator}
      op1 [refines] = {number}

      op1 .value = 12
      op2 = true

      layer .operator = ""
      layer .priority = 1
      layer [meta] .operands_type = number

      layer .operands [1] = op1
      layer .operands [2] = op2
      

      Layer.Proxy.check_all (layer)

      assert.is_not_nil (next (Layer.messages))
    end)
  end)
end)
