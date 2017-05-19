return function (Layer, addition, ref)

  local refines    = Layer.key.refines
  local meta       = Layer.key.meta
  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"

  addition [refines] = {
    operator
  }
  addition [meta] = {
    of       = false,
    operands = {
      [refines] = { collection },
      [meta   ] = {
        [collection] = {
          minimum    = 2,
          maximum    = 2,
          value_type = ref [meta].of,
        },
      },
    },
  }

  return addition
end
