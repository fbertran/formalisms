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
    

    ["cosy.formalism.operation.arithmetic"] = "src/cosy/formalism/operation/arithmetic/init.lua",
    ["cosy.formalism.operation.arithmetic.addition"] = "src/cosy/formalism/operation/arithmetic/addition.lua",
    ["cosy.formalism.operation.arithmetic.substraction"] = "src/cosy/formalism/operation/arithmetic/substraction.lua",
    ["cosy.formalism.operation.arithmetic.multiplication"] = "src/cosy/formalism/operation/arithmetic/multiplication.lua",
    ["cosy.formalism.operation.arithmetic.division"] = "src/cosy/formalism/operation/arithmetic/division.lua",

    ["cosy.formalism.operation.logical"] = "src/cosy/formalism/operation/logical/init.lua",
    ["cosy.formalism.operation.logical.and"] = "src/cosy/formalism/operation/logical/and.lua",
    ["cosy.formalism.operation.logical.or"] = "src/cosy/formalism/operation/logical/or.lua",
    ["cosy.formalism.operation.logical.xor"] = "src/cosy/formalism/operation/logical/xor.lua",
    ["cosy.formalism.operation.logical.nor"] = "src/cosy/formalism/operation/logical/nor.lua",

    ["cosy.formalism.operation.boolean"] = "src/cosy/formalism/operation/boolean/init.lua",
    ["cosy.formalism.operation.boolean.not"] = "src/cosy/formalism/operation/boolean/not.lua",

    ["cosy.formalism.operation.relational"] = "src/cosy/formalism/operation/relational/init.lua",
    ["cosy.formalism.operation.relational.inferior"] = "src/cosy/formalism/operation/relational/inferior.lua",
    ["cosy.formalism.operation.relational.inferiorequal"] = "src/cosy/formalism/operation/relational/inferiorequal.lua",
    ["cosy.formalism.operation.relational.equal"] = "src/cosy/formalism/operation/relational/equal.lua",
    ["cosy.formalism.operation.relational.different"] = "src/cosy/formalism/operation/relational/different.lua",
    ["cosy.formalism.operation.relational.superior"] = "src/cosy/formalism/operation/relational/superior.lua",
    ["cosy.formalism.operation.relational.superiorequal"] = "src/cosy/formalism/operation/relational/superiorequal.lua",

    ["cosy.formalism.operation.assignment"] = "src/cosy/formalism/operation/assignment/init.lua",

    ["cosy.formalism.operation.logical.operands_type"] = "src/cosy/formalism/operation/logical/operands_type.lua",
    ["cosy.formalism.operation.arithmetic.operands_type"] = "src/cosy/formalism/operation/arithmetic/operands_type.lua",
    ["cosy.formalism.operation.relational.operands_type"] = "src/cosy/formalism/operation/relational/operands_type.lua",
    ["cosy.formalism.operation.boolean.operands_type"] = "src/cosy/formalism/operation/boolean/operands_type.lua",


    ["cosy.formalism.operator"] = "src/cosy/formalism/operator/init.lua",
    ["cosy.formalism.operator.operation"] = "src/cosy/formalism/operator/operation.lua",

    ["cosy.formalism.automaton.timed"] = "src/cosy/formalism/automaton/timed/init.lua",

    ["cosy.formalism.automaton.timed.parametric"] = "src/cosy/formalism/automaton/timed/parametric/init.lua",
    ["cosy.formalism.automaton.timed.parametric.network"] = "src/cosy/formalism/automaton/timed/parametric/network.lua",

    ["cosy.formalism.automaton.timed.parametric.imitator"] = "src/cosy/formalism/automaton/timed/parametric/imitator/init.lua",
    ["cosy.formalism.automaton.timed.parametric.imitator.network"] = "src/cosy/formalism/automaton/timed/parametric/imitator/network.lua",

  },
}
