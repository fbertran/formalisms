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

    ["cosy.formalism.parsable"] = "src/cosy/formalism/parsable/init.lua",

    ["cosy.formalism.data.check_container"] = "src/cosy/formalism/data/check_container.lua",
    ["cosy.formalism.data.collection"     ] = "src/cosy/formalism/data/collection.lua",
    ["cosy.formalism.data.enumeration"    ] = "src/cosy/formalism/data/enumeration.lua",
    ["cosy.formalism.data.polynomial"     ] = "src/cosy/formalism/data/polynomial.lua",
    ["cosy.formalism.data.record"         ] = "src/cosy/formalism/data/record.lua",

    ["cosy.formalism.environment"] = "src/cosy/formalism/environment/init.lua",

    ["cosy.formalism.graph"                 ] = "src/cosy/formalism/graph/init.lua",
    ["cosy.formalism.graph.directed"        ] = "src/cosy/formalism/graph/directed.lua",
    ["cosy.formalism.graph.binary_edges"    ] = "src/cosy/formalism/graph/binary_edges.lua",
    ["cosy.formalism.graph.unique_edges"    ] = "src/cosy/formalism/graph/unique_edges.lua",
    ["cosy.formalism.environment.ngraph"] = "src/cosy/formalism/environment/ngraph.lua",

    ["cosy.formalism.automaton"    ] = "src/cosy/formalism/automaton/init.lua",
    ["cosy.formalism.environment.nautomaton"] = "src/cosy/formalism/environment/nautomaton/init.lua",

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
    ["cosy.formalism.operator.arithmetic.addition"] = "src/cosy/formalism/operator/arithmetic/addition.lua",
    ["cosy.formalism.operator.arithmetic.addnary"] = "src/cosy/formalism/operator/arithmetic/addnary.lua",
    ["cosy.formalism.operator.arithmetic.substraction"] = "src/cosy/formalism/operator/arithmetic/substraction.lua",
    ["cosy.formalism.operator.arithmetic.multiplication"] = "src/cosy/formalism/operator/arithmetic/multiplication.lua",
    ["cosy.formalism.operator.arithmetic.division"] = "src/cosy/formalism/operator/arithmetic/division.lua",
    ["cosy.formalism.operator.arithmetic.increment"] = "src/cosy/formalism/operator/arithmetic/increment.lua",

    ["cosy.formalism.operation.logical"] = "src/cosy/formalism/operation/logical/init.lua",
    ["cosy.formalism.operator.logical.and"] = "src/cosy/formalism/operator/logical/and.lua",
    ["cosy.formalism.operator.logical.or"] = "src/cosy/formalism/operator/logical/or.lua",
    ["cosy.formalism.operator.logical.xor"] = "src/cosy/formalism/operator/logical/xor.lua",
    ["cosy.formalism.operator.logical.nor"] = "src/cosy/formalism/operator/logical/nor.lua",

    ["cosy.formalism.operation.boolean"] = "src/cosy/formalism/operation/boolean/init.lua",
    ["cosy.formalism.operator.boolean.not"] = "src/cosy/formalism/operator/boolean/not.lua",

    ["cosy.formalism.operation.relational"] = "src/cosy/formalism/operation/relational/init.lua",
    ["cosy.formalism.operator.relational.inferior"] = "src/cosy/formalism/operator/relational/inferior.lua",
    ["cosy.formalism.operator.relational.inferiorequal"] = "src/cosy/formalism/operator/relational/inferiorequal.lua",
    ["cosy.formalism.operator.relational.equal"] = "src/cosy/formalism/operator/relational/equal.lua",
    ["cosy.formalism.operator.relational.different"] = "src/cosy/formalism/operator/relational/different.lua",
    ["cosy.formalism.operator.relational.superior"] = "src/cosy/formalism/operator/relational/superior.lua",
    ["cosy.formalism.operator.relational.superiorequal"] = "src/cosy/formalism/operator/relational/superiorequal.lua",


    ["cosy.formalism.operation.assignment"] = "src/cosy/formalism/operation/assignment/init.lua",
    ["cosy.formalism.operator.assignment"] = "src/cosy/formalism/operator/assignment/init.lua",  


    ["cosy.formalism.operator"] = "src/cosy/formalism/operator/init.lua",
    
    ["cosy.formalism.operator.binary"] = "src/cosy/formalism/operator/binary.lua",
    ["cosy.formalism.operator.nullary"] = "src/cosy/formalism/operator/nullary/init.lua",
    ["cosy.formalism.operator.nary"] = "src/cosy/formalism/operator/nary/init.lua",
    ["cosy.formalism.operator.nary.prefix"] = "src/cosy/formalism/operator/nary/prefix.lua",
    ["cosy.formalism.operator.nary.suffix"] = "src/cosy/formalism/operator/nary/suffix.lua",
    
    ["cosy.formalism.operator.unary"] = "src/cosy/formalism/operator/unary/init.lua",
    ["cosy.formalism.operator.unary.prefix"] = "src/cosy/formalism/operator/unary/prefix.lua",
    ["cosy.formalism.operator.unary.suffix"] = "src/cosy/formalism/operator/unary/suffix.lua",

    ["cosy.formalism.operation.punctuator"] = "src/cosy/formalism/operation/punctuator/init.lua",
    ["cosy.formalism.operator.punctuator.parenthesis"] = "src/cosy/formalism/operator/punctuator/parenthesis.lua",
    ["cosy.formalism.operator.punctuator.accolade"] = "src/cosy/formalism/operator/punctuator/accolade.lua",

    
    ["cosy.formalism.flag"] = "src/cosy/formalism/flag/init.lua",
    ["cosy.formalism.flag.operands_type"] = "src/cosy/formalism/flag/operands_type.lua",
    ["cosy.formalism.flag.operation_inclusion"] = "src/cosy/formalism/flag/operation_inclusion.lua",

    ["cosy.formalism.automaton.timed"] = "src/cosy/formalism/automaton/timed/init.lua",
    ["cosy.formalism.environment.nautomaton.timed"] = "src/cosy/formalism/environment/nautomaton/timed/init.lua",

    ["cosy.formalism.automaton.timed.parametric"] = "src/cosy/formalism/automaton/timed/parametric/init.lua",
    ["cosy.formalism.environment.nautomaton.timed.parametric"] = "src/cosy/formalism/environment/nautomaton/timed/parametric/init.lua",

    ["cosy.formalism.automaton.timed.parametric.imitator"] = "src/cosy/formalism/automaton/timed/parametric/imitator/init.lua",
    ["cosy.formalism.environment.nautomaton.timed.parametric.imitator"] = "src/cosy/formalism/environment/nautomaton/timed/parametric/imitator/init.lua",
    ["cosy.formalism.drawable"] = "src/cosy/formalism/drawable/init.lua",
  

  },
}
