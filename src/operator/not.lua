return function (Layer, not_operator)
  local refines = Layer.key.refines

  local operator = Layer.require "operator"
  local collection = Layer.require "data.collection"

  local _, re = Layer.require "expression"

  not_operator [refines] = {
    operator,
  }

  not_operator [meta] = {
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

  return not_operator
end
