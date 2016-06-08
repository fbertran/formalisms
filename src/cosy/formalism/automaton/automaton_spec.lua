if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end
--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism automaton", function ()

  it ("can be loaded", function ()

    local _ = Layer.require "cosy/formalism/automaton"
  end)

    end)

