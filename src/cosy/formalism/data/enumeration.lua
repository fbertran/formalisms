-- Enumerations
-- ============
--
-- This formalism describes what is an enumeration: a set of symbols.
-- We do not use the usual Lua representation for sets (name to Boolean),
-- as we want the symbols to be referenced by other parts of the models.
-- Instead, the `symbols` collection uses symbols as values. this does not
-- guarantee uniqueness of the symbols.

return function (Layer, enumeration, ref)

  local defaults = Layer.key.defaults
  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local collection = Layer.require "cosy/formalism/data.collection"

  enumeration [refines] = {
    collection,
  }

  enumeration [meta] = {
    enumeration = {
      symbol_type = false,
    },
    collection = {
      value_type = ref [meta].enumeration.symbol_type,
    },
  }

  enumeration [defaults] = {
    ref [meta].enumeration.symbol_type,
  }

end
