local Layer = require "layeredata"

Layer.require = function (name)
  local package = name:gsub ("/", ".")
  if Layer.loaded [package] then
    return Layer.loaded [package]
  else
    local layer = Layer.new {
      name = name,
      data = {
        [Layer.key.labels] = {
          [name] = true,
        }
      }
    }
    local reference = Layer.reference (name)
    layer = require (package) (Layer, layer, reference) or layer
    return layer, reference
  end
end

return Layer
