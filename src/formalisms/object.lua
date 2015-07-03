local Layer = require "layeredata"
local layer = Layer.new {
  name = "container",
}

-- container formalism
-- ================
--
-- a container is a table where:
-- * keys and values are typed or contained in another container.
-- * keys can be explicit and values

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
        -- TODO
        -- check if all the keys have the great type, all the values have the great type and so on...
      end,
    },
  },
  record = {
    __meta__ = {
      __tags__ = {},
    },
    __checks__ = {
      function ()
        -- TODO
        -- check if the record contains all the keys in tags and values have the great type
      end,
    },
  },
}
return layer
