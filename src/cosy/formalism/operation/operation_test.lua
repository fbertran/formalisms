
local Layer = require "layeredata"
local arithmetic_operation = Layer.require "cosy/formalism/operation/arithmetic"
--local collection = Layer.require "cosy/formalism/data.collection"
local arithmetic_variant = Layer.new {}


arithmetic_variant [Layer.key.refines] = {arithmetic_operation}

--Layer.Proxy.check_all(arithmetic_variant)
--assert.is_nil(next ( Layer.messages ) )
print(arithmetic_variant)
--affichage du ref affecté
print(arithmetic_variant [Layer.key.meta].operands_type)
--affichage du ref hérité
print(arithmetic_variant [Layer.key.meta].operators[1][Layer.key.refines][2])

