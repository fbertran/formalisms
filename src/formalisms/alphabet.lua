local Proxy = require "layeredata"
local layer = Proxy.new { 
  name = "alphabet",
}
local _     = Proxy.placeholder

-- 
layer.alphabet_type = {

  __meta__ = {
    symbol_type = {},
  },

  symbols = {
    __meta__ = {
      content_type = _.alphabet_type.__meta__.symbol_type,
    },
  },
}

return layer
