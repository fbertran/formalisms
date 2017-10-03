return function (Layer, and_op)
  local refines    = Layer.key.refines
  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"
  local _, re      = Layer.require "expression"

  and_op[refines] = { operator }

  and_op [meta] = {
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

  return and_op
end
