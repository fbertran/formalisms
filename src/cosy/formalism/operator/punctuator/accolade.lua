return function (Layer, accolade)

  local refines = Layer.key.refines
  local meta = Layer.key.meta
  local lpeg = require "lpeg"
  local suffix = Layer.require "cosy/formalism/operator/unary.suffix"

  accolade [refines] = {
    suffix
  }
  accolade .priority = 1

  accolade [meta].parser = function (base,ref)
    return (lpeg.P "{" * base * (lpeg.P "}")/function(op)
      local layer = Layer.new {}
      layer [refines] = { ref }
      layer.operands = {op}
      return layer
    end)
  end

end