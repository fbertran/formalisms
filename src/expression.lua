return function (Layer, expression, ref)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local collection = Layer.require "data.collection"
  local record     = Layer.require "data.record"
  local operator   = Layer.require "operator"

  expression [refines] = {
    record,
  }

  expression [meta] = {
    [expression] = {
      [refines] = { collection },
      [meta   ] = {
        [collection] = {
          value_type = operator,
        },
      },
    },
    [record] = {
      operator = {
        value_container = ref [meta] [expression],
      },
    },
  }

  expression.operands = {
    [refines] = {
      ref.operator [meta].operands,
    },
  }

  return expression
end
