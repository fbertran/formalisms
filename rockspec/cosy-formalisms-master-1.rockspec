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

dependencies = {
  "lua >= 5.1",
  "layeredata",
  "coronest",
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


    ["cosy.formalism.action"] = "src/cosy/formalism/action/init.lua",
    ["cosy.formalism.action.synchronized"] = "src/cosy/formalism/action/synchronized.lua",
    ["cosy.formalism.action.nonsynchronized"] = "src/cosy/formalism/action/nonsynchronized.lua",

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
    ["cosy.formalism.operation.nor_operation"] = "src/cosy/formalism/operation/nor_operation.lua",

    ["cosy.formalism.operation.boolean_operation"] = "src/cosy/formalism/operation/boolean_operation.lua",
    ["cosy.formalism.operation.not_operation"] = "src/cosy/formalism/operation/not_operation.lua",

    ["cosy.formalism.operation.relational_operation"] = "src/cosy/formalism/operation/relational_operation.lua",
    ["cosy.formalism.operation.inferior_operation"] = "src/cosy/formalism/operation/inferior_operation.lua",
    ["cosy.formalism.operation.inferiorequal_operation"] = "src/cosy/formalism/operation/inferiorequal_operation.lua",
    ["cosy.formalism.operation.equal_operation"] = "src/cosy/formalism/operation/equal_operation.lua",
    ["cosy.formalism.operation.different_operation"] = "src/cosy/formalism/operation/different_operation.lua",
    ["cosy.formalism.operation.superior_operation"] = "src/cosy/formalism/operation/superior_operation.lua",
    ["cosy.formalism.operation.superiorequal_operation"] = "src/cosy/formalism/operation/superiorequal_operation.lua",



    ["cosy.formalism.automaton.timed_automaton"] = "src/cosy/formalism/automaton/timed_automaton/init.lua",


    ["cosy.formalism.automaton.timed_automaton.literal"] = "src/cosy/formalism/automaton/timed_automaton/literal/init.lua",
    ["cosy.formalism.automaton.timed_automaton.literal.string"] = "src/cosy/formalism/automaton/timed_automaton/literal/string.lua",
    ["cosy.formalism.automaton.timed_automaton.literal.number"] = "src/cosy/formalism/automaton/timed_automaton/literal/number.lua",
    ["cosy.formalism.automaton.timed_automaton.literal.bool"] = "src/cosy/formalism/automaton/timed_automaton/literal/bool.lua",
    ["cosy.formalism.automaton.timed_automaton.literal.identifier"] = "src/cosy/formalism/automaton/timed_automaton/literal/identifier.lua",

    
    ["cosy.formalism.automaton.timed_automaton.operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/init.lua",

    ["cosy.formalism.automaton.timed_automaton.operation.arithmetic_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/arithmetic_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.addition_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/addition_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.substraction_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/substraction_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.multiplication_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/multiplication_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.division_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/division_operation.lua",

    ["cosy.formalism.automaton.timed_automaton.operation.logical_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/logical_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.and_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/and_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.or_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/or_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.xor_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/xor_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.nor_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/nor_operation.lua",

    ["cosy.formalism.automaton.timed_automaton.operation.boolean_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/boolean_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.not_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/not_operation.lua",

    ["cosy.formalism.automaton.timed_automaton.operation.relational_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/relational_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.inferior_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/inferior_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.inferiorequal_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/inferiorequal_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.equal_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/equal_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.different_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/different_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.superior_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/superior_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.operation.superiorequal_operation"] = "src/cosy/formalism/automaton/timed_automaton/operation/superiorequal_operation.lua",
 



 
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/init.lua",


    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/init.lua",

    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.arithmetic_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/arithmetic_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.addition_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/addition_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.substraction_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/substraction_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.multiplication_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/multiplication_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.division_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/division_operation.lua",

    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.logical_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/logical_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.and_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/and_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.or_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/or_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.xor_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/xor_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.nor_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/nor_operation.lua",

    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.boolean_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/boolean_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.not_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/not_operation.lua",

    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.relational_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/relational_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.inferior_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/inferior_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.inferiorequal_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/inferiorequal_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.equal_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/equal_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.different_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/different_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.superior_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/superior_operation.lua",
    ["cosy.formalism.automaton.timed_automaton.parametric_timed_automaton.condition_params.superiorequal_operation"] = "src/cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/superiorequal_operation.lua",

  },
}
