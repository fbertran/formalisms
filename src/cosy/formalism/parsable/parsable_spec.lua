--These lines are required to correctly run tests.
if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end
require "busted.runner" ()

local Layer   = require "layeredata"
local meta    = Layer.key.meta

describe ("Formalism parsable", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/parsable"
  end)

  it ("allows no definition of function parser and printer", function ()
    local layer = Layer.require "cosy/formalism/parsable"

    layer [meta] .parser  = nil
    layer [meta] .printer = nil

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it ("forbids a diffrent type for parser", function ()
    local layer = Layer.require "cosy/formalism/parsable"

    layer [meta] .parser  = "lol"
    layer [meta] .printer = nil

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("forbids a diffrent type for printer", function ()
    local layer = Layer.require "cosy/formalism/parsable"

    layer [meta] .parser  = nil
    layer [meta] .printer = 42

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

end)
