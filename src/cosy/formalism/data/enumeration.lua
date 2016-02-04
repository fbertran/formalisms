-- Enumerations
-- ============
--
-- This formalism describes what is an enumeration: a set of symbols.
-- We do not use the usual Lua representation for sets (name to Boolean),
-- as we want the symbols to be referenced by other parts of the models.
-- Instead, the `symbols` collection uses symbols as values. this does not
-- guarantee uniqueness of the symbols.

return function (Layer)

  local default  = Layer.key.default
  local labels   = Layer.key.labels
  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local collection = Layer.require "cosy/formalism/data.collection"

  local enumeration = Layer.new {
    name = "cosy/formalism/data.enumeration",
  }

  enumeration [labels] = {
    ["cosy/formalism/data.enumeration"] = true,
  }
  local _ = Layer.reference "cosy/formalism/data.enumeration"

  enumeration [refines] = {
    collection,
  }

  enumeration [meta] = {
    symbol_type = false,
    collection = {
      value_type = _ [meta].symbol_type,
    },
  }

  enumeration [default] = {
    [refines] = {
      _ [meta].symbol_type,
    },
  }

  return enumeration

end
