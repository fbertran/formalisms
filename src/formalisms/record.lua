local Layer = require "layeredata"
local layer = Layer.new {
  name = "record",
}

-- record formalism
-- ================
--
-- a record is a table where some keys are obligated.
-- To do that we introduce the special key `__tags__`.


layer.__meta__ = {
  record = {
    __meta__ = {
      __tags__ = {
        -- If you want a key `name` in your record you wrote this :

        -- `name = {`  
        --    `__value_type__      = string,`  
        --    `__value_container__ = nil,`  
        --  `},`  

        -- in `__tags__`.
      },
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
