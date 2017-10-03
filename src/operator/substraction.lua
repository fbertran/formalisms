return function (Layer, substraction)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"
  local _, re      = Layer.require "expression"

  substraction [refines] = {
    operator,
  }

  substraction [meta] = {
    of       = false,
    operands = {
      [refines] = { collection },
      [meta   ] = {
        [collection] = {
          minimum    = 2,
          maximum    = 2,
          value_type = re.operator [meta].of,
        },
      },
    },
  }

  return substraction
end
