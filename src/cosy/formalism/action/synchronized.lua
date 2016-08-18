-- Synchronized

return function (Layer, synchronized,ref)

  local meta       = Layer.key.meta
  local refines    = Layer.key.refines
  local action     = Layer.require "cosy/formalism/action"
  local string     = Layer.require "cosy/formalism/literal.string"
  local record     = Layer.require "cosy/formalism/data.record"
	local collection = Layer.require "cosy/formalism/data.collection"  
  
  synchronized [refines] = {
    action,
  }

  synchronized [meta] .types = {}
  synchronized [meta] .types [refines] = {collection}

  synchronized [meta] .types .send = {}
  synchronized [meta] .types .send [refines] = {string}
  synchronized [meta] .types .send .value = "send"

  synchronized [meta] .types .recv = {}
  synchronized [meta] .types .recv [refines] = {string}
  synchronized [meta] .types .recv .value = "recv"

  synchronized [meta] [record] .type = { value_container = ref [meta] .types }

end
