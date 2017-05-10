<!-- footer: Lars Gabriel Annell Rydenvald --->

<h1 style="text-align: center; font-size: 120px">Ardoises</h1>
<h1 style="text-align: center">Expressions</h1>

---

# Ardoises<small><sup>[1][1]</sup></small>
* Formal modeling platform
* Provides a graphical interface to view, create and modify the models


---

# Existing software for formal modeling
* CPN-AMI
* CosyVerif
* metaDepth
* AtomPM

None of these provide the level of parametrisation that Ardoises aims to give to the users

---

# Formalisms<small><sup>[2][2]</sup></small>

* Standard library to be used with Ardoises
* Defines useful formalisms such as collections, records, enumerations, graphs and Petri nets

---

# Layeredata

* Implements prototypal inheritance (does not exist in the Lua language)
* Permits instanciation of the formalisms

---

<h1 style="text-align: center">Project goals</h1>

---

# Project goals

* Main work to be done for the Formalisms library
  * Define expression formalisms
  * Implement a parser / pretty-printer
  * Create examples for the users
* Possibly work on part of the Ardoises graphical interface

---

<h1 style="text-align: center">Some code</h1>

---

# Defining an operator
Describing an operator:

<pre style="font-size: 13px">
  Operator [refines] = {
    record,
  }

  Operator [meta] = {}

  Operator [meta] = {
    [record] = {
      operator = {
        value_type = "string",
        optional   = true,
      },
      priority = {
        value_type = "number",
        optional   = true,
      },
      is_associative = {
        value_type = "boolean",
        optional   = false,
      },
      is_commutative = {
        value_type = "boolean",
        optional   = false,
      },
      operands = false,
    },
  }

  Operator.is_associative = false
  Operator.is_commutative = false
</pre>

---

# Defining an operator

Example: Multiplication operator

<pre style="font-size: 13px">
  Multiplication [refines] = {
    operator,
  }

  Multiplication.operator = "*"
  Multiplication.priority = 12

  Multiplication.is_associative = true
  Multiplication.is_commutative = true
  Multiplication.operands = {
    [collection] = {
      minimum = 2,
      maximum = 2,
      value_type = "number",
    },
    type = collection,
  }
</pre>

---

# Defining an expression
Generic expression:

<pre style="font-size: 13px">
  Expression [refines] = {
    record,
  }

  Expression [meta] = {
    [record] = {
      operator = {
        value_type = operator,
        optional   = false,
      },
      operands = {
        optional = false,
      },
    },
  }

  Expression.operands = {
    [refines] = {
      ref.operator.operands.type,
    },
    [meta] = ref.operator.operands,
  }
</pre>

---

# Defining an expression
Example: multiplication

<pre style="font-size: 13px">
  Multiplication_Expression [refines] = {
    expression,
  }

  Multiplication_Expression.operator = multiplication
</pre>

---

# Defining a grammar
Desribing a grammar:
<pre style="font-size: 13px">
  Grammar.expressions = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        minimum = 1,
      },
    },
  }
</pre>

---

# Defining a grammar

Example: arithmetic grammar	

<pre style="font-size: 13px">

  Arithmetic_Grammar [refines] = {
    grammar,
  }

  Arithmetic_Grammar.expressions = {
    sub_expr,
    add_expr,
    mul_expr,
    div_expr,
    exp_expr,
  }
</pre>

[1]: https://ardoises.ovh/overview
[2]: https://github.com/ardoises/formalisms/tree/dev