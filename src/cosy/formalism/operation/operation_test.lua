local Layer = require "layeredata"
local arithmetic_operation = Layer.require "cosy/formalism/operation/arithmetic"
local multiplication_operation = Layer.require "cosy/formalism/operation/arithmetic.multiplication"
local collection = Layer.require "cosy/formalism/data.collection"
local arithmetic_variant = Layer.new {}
local arithmetic_var2 = Layer.new {}
arithmetic_variant [Layer.key.refines] = {arithmetic_operation}
arithmetic_var2 [Layer.key.refines] = {arithmetic_operation}
print(arithmetic_variant [Layer.key.meta].operators[multiplication_operation])
print(arithmetic_operation [Layer.key.meta].operators[multiplication_operation])