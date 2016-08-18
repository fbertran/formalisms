-- These lines are required to correctly run tests.
if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism action", function ()

  it ("can be loaded", function ()

    local _ = Layer.require "cosy/formalism/action"

  end)
end)
