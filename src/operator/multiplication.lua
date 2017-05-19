return function (Layer, multiplication, ref)

  local refines    = Layer.key.refines
  local meta       = Layer.key.meta
  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"
  local _, re      = Layer.require "expression"

  multiplication [refines] = {
    operator,
  }

  -- multiplication.operator = "*"
  -- multiplication.priority = 12
  -- multiplication.is_associative = true
  -- multiplication.is_commutative = true
  -- print (re.operator [meta].of)

  multiplication [meta] = {
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

  return multiplication
end
