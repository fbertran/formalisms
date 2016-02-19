local Layer = require "layeredata"

local oldnew = Layer.new

Layer.new = function (t)
  assert (t.name)
  local layer = oldnew (t)
  if not layer [Layer.key.labels] then
    layer [Layer.key.labels] = {}
  end
  layer [Layer.key.labels] [t.name] = true
  local reference = Layer.reference (t.name)
  return layer, reference
end

Layer.require = function (name)
  local package = name:gsub ("/", ".")
  if Layer.loaded [package] then
    return Layer.loaded [package]
  else
    local layer = Layer.new {
      name = name,
    }
    local reference = Layer.reference (name)
    layer = require (package) (Layer, layer, reference) or layer
    return layer, reference
  end
end

return Layer
