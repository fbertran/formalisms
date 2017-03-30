require "busted.runner" ()

describe ("Formalism operator", function ()
    describe ("operator", function () 
      it ("can be created", function () 
        local Layer = require "layeredata"
        local operator = Layer.require "operator"
        local layer = Layer.new {}
        layer [Layer.key.refines] = { operator }
        assert.is_nil (next (Layer.messages))
      end)
    end)
end)
