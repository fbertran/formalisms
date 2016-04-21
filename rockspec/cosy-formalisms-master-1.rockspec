package = "cosy-formalisms"
version = "master-1"

source = {
  url = "git://github.com/Seriane/formalisms",
}

description = {
  summary     = "Formalisms for CosyVerif",
  detailed    = [[]],
  license     = "MIT/X11",
  maintainer  = "Alban Linard <alban@linard.fr>",
}



build = {
  type    = "builtin",
  modules = {
    ["cosy.formalism.layer"] = "src/cosy/formalism/layer.lua",
    ["cosy.formalism.tool" ] = "src/cosy/formalism/tool/init.lua",

    ["cosy.formalism.type"            ] = "src/cosy/formalism/type/init.lua",
    ["cosy.formalism.type.check"      ] = "src/cosy/formalism/type/check.lua",
    ["cosy.formalism.type.all_of"     ] = "src/cosy/formalism/type/all_of.lua",
    ["cosy.formalism.type.one_of"     ] = "src/cosy/formalism/type/one_of.lua",
    ["cosy.formalism.type.constrained"] = "src/cosy/formalism/type/constrained.lua",

    ["cosy.formalism.data.check_container"] = "src/cosy/formalism/data/check_container.lua",
    ["cosy.formalism.data.collection"     ] = "src/cosy/formalism/data/collection.lua",
    ["cosy.formalism.data.enumeration"    ] = "src/cosy/formalism/data/enumeration.lua",
    ["cosy.formalism.data.polynomial"     ] = "src/cosy/formalism/data/polynomial.lua",
    ["cosy.formalism.data.record"         ] = "src/cosy/formalism/data/record.lua",

    ["cosy.formalism.graph"                 ] = "src/cosy/formalism/graph/init.lua",
    ["cosy.formalism.graph.directed"        ] = "src/cosy/formalism/graph/directed.lua",
    ["cosy.formalism.graph.binary_edges"    ] = "src/cosy/formalism/graph/binary_edges.lua",
    ["cosy.formalism.graph.unique_edges"    ] = "src/cosy/formalism/graph/unique_edges.lua",

    ["cosy.formalism.automaton"    ] = "src/cosy/formalism/automaton/init.lua",


    ["cosy.formalism.alphabet"] = "src/cosy/formalism/alphabet/init.lua",
    ["cosy.formalism.alphabet.synchronized"] = "src/cosy/formalism/alphabet/synchronized.lua",
    ["cosy.formalism.alphabet.nonsynchronized"] = "src/cosy/formalism/alphabet/nonsynchronized.lua",

    ["cosy.formalism.literal"] = "src/cosy/formalism/literal/init.lua",
    ["cosy.formalism.literal.string"] = "src/cosy/formalism/literal/string.lua",
    ["cosy.formalism.literal.number"] = "src/cosy/formalism/literal/number.lua",
    ["cosy.formalism.literal.bool"] = "src/cosy/formalism/literal/bool.lua",
    ["cosy.formalism.literal.identifier"] = "src/cosy/formalism/literal/identifier.lua",

    ["cosy.formalism.expression"] = "src/cosy/formalism/expression/init.lua",
    ["cosy.formalism.expression.arithmetic_expression"] = "src/cosy/formalism/expression/arithmetic_expression.lua",
    ["cosy.formalism.expression.boolean_expression"] = "src/cosy/formalism/expression/boolean_expression.lua",
    ["cosy.formalism.expression.logical_expression"] = "src/cosy/formalism/expression/logical_expression.lua",
    ["cosy.formalism.expression.relational_expression"] = "src/cosy/formalism/expression/relational_expression.lua",

    ["cosy.formalism.operation"] = "src/cosy/formalism/operation/init.lua",

	["cosy.formalism.operation.arithmetic_operation"] = "src/cosy/formalism/operation/arithmetic_operation.lua",
    ["cosy.formalism.operation.addition_operation"] = "src/cosy/formalism/operation/addition_operation.lua",
    ["cosy.formalism.operation.substraction_operation"] = "src/cosy/formalism/operation/substraction_operation.lua",
    ["cosy.formalism.operation.multiplication_operation"] = "src/cosy/formalism/operation/multiplication_operation.lua",
    ["cosy.formalism.operation.division_operation"] = "src/cosy/formalism/operation/division_operation.lua",

    ["cosy.formalism.operation.logical_operation"] = "src/cosy/formalism/operation/logical_operation.lua",
    ["cosy.formalism.operation.and_operation"] = "src/cosy/formalism/operation/and_operation.lua",
    ["cosy.formalism.operation.or_operation"] = "src/cosy/formalism/operation/or_operation.lua",
    ["cosy.formalism.operation.xor_operation"] = "src/cosy/formalism/operation/xor_operation.lua",

    ["cosy.formalism.operation.boolean_operation"] = "src/cosy/formalism/operation/boolean_operation.lua",
    ["cosy.formalism.operation.not_operation"] = "src/cosy/formalism/operation/not_operation.lua",
    
    
    
    ["cosy.formalism.operation.relational_operation"] = "src/cosy/formalism/operation/relational_operation.lua",
    ["cosy.formalism.operation.superiorequal_operation"] = "src/cosy/formalism/operation/superiorequal_operation.lua",
    ["cosy.formalism.operation.superior_operation"] = "src/cosy/formalism/operation/superior_operation.lua",
    ["cosy.formalism.operation.equal_operation"] = "src/cosy/formalism/operation/equal_operation.lua",
    ["cosy.formalism.operation.different_operation"] = "src/cosy/formalism/operation/different_operation.lua",
    ["cosy.formalism.operation.inferiorequal_operation"] = "src/cosy/formalism/operation/inferiorequal_operation.lua",
    ["cosy.formalism.operation.inferior_operation"] = "src/cosy/formalism/operation/inferior_operation.lua",


  },
}
