local Layer = require "layeredata"
local layer = Layer.new {
  name = "collection",
}

-- collection formalism
-- ================
--
-- a collection is a table where keys and values are typed or contained in another container.
--
-- To do those there are 4 special keys :
-- * `__key_type__`        : type of keys
-- * `__key_container__`   : all keys must reference an element of this container
-- * `__value_type__`      : type of values
-- * `__value_container__` : all values must reference an element of this container


layer.__meta__ = {
  collection = {
    __meta__ = {
      __key_type__        = nil,
      __key_container__   = nil,
      __value_type__      = nil,
      __value_container__ = nil,
    },

    __checks__ = {
      function ()
        -- TODO b
        -- check if all the keys have the great type, all the values have the great type and so on...
      end,
    },
  },
}
return layer
