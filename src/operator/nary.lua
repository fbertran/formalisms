return function (Layer, nary)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"
  local record     = Layer.require "data.record"

  nary [refines] = {
    operator,
  }

  nary.operands = {
    [meta] = {
      [collection] = {
        minimum = 1,
      },
    }
  }

  nary [meta] = {
    [record] = {
      operator = {
        optional = false,
      },
      priority = {
        optional = false,
      },
    },
  }

  return nary
end
