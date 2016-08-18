--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer   = require "layeredata"
local path    = "cosy/formalism/operator/relational.different"

describe ("Formalism different", function ()
  it ("can be loaded", function ()
    local _ = Layer.require (path)
  end)
end)
