local Layer = require "layeredata"

local layer = Layer.new {
  name = "object",
}

-- object formalism
-- ================
--
-- We describe here object class
--
-- this class describe two prototypes, collections and records

layer.__meta__ = {
  object_type = {
    collection = {
      __meta__ = {
        __key_type__        = nil,
        __key_container__   = nil,
        __value_type__      = nil,
        __value_container__ = nil,
      },

      __default__ = {
        __key_type__        = nil,
        __key_container__   = nil,
        __value_type__      = nil,
        __value_container__ = nil,
      },

      __checks__ = {
        function (element)
          -- TODO : checks if element respect the key_type, ...
        end
      },

    },
    
    record = {
      __meta__ = {
        __tags__ = {},
        __checks__ = {
          function (element)
            -- TODO : checks if element contains the elements in tags
          end
        },
      },
    },
  },
}

return layer
