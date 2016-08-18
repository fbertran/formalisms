return function (Layer,nary)

  local meta      = Layer.key.meta
  local refines   = Layer.key.refines
  local operator  = Layer.require "cosy/formalism/operator"
  local record    = Layer.require "cosy/formalism/data.record"

  nary [refines]  = { operator }

  nary [meta] [record] .operator .optional = false
  nary [meta] [record] .priority .optional = false

end