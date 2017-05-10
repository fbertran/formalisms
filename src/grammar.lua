return function (Layer, Grammar)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local collection = Layer.require "data.collection"

  Grammar.expressions = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        minimum = 1,
        maximum = 65000,
      },
    },
  }

  return Grammar
end
