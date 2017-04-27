return function (Layer, Expression, ref)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local record   = Layer.require "data.record"
  local operator = Layer.require "operator"

  Expression [refines] = {
    record,
  }

  Expression [meta] = {
    [record] = {
      operator = {
        value_type = operator,
        optional   = false,
      },
      operands = {
        optional = false,
      },
    },
  }

  Expression.operands = {
    [refines] = {
      ref.operator.operands.type,
    },
    [meta] = ref.operator.operands,
  }

  return Expression
end
