-- These lines are required to correctly run tests.

--[[if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()


local Layer = require "cosy.formalism.layer"

describe ("Formalism operation.addition", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/operation.addition_operation"
  end)

end)

]]
