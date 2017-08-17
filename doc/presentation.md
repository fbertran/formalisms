<!-- footer: Lars Gabriel Annell Rydenvald --->

<h1 style="text-align: center; font-size: 120px">Ardoises</h1>
<h1 style="text-align: center">Operator and expression formalisms</h1>

---

# Ardoises
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

# Formalisms

* Standard library to be used with Ardoises
* Defines useful formalisms such as collections, records, enumerations, graphs and Petri nets

---

# Layeredata

* Implements prototypal inheritance (does not exist in the Lua language)
* Model instanciation
* Model property verification

---

<h1 style="text-align: center">Operator formalisms</h1>

---

### Most important feature
* Modularity

--- 

# Achieving modularity

Let the expression that uses the operator model define the type of the operands

---

# Example - Addition operator

<pre style="font-size:13px">
addition [meta] = {
  operands = {
    [refines] = { collection },
    [meta   ] = {
      [collection] = {
        minimum    = 2,
        maximum    = 2,
        value_type = re.operator [meta].of, -- re is a reference to the expression model
      },
    },
  },
}
</pre>

---

# Example - Addition operator
### Using it in an expression
The type of the operands are defined here
<pre style="font-size:13px">
local r_addition = {
  [refines] = { addition },
  [meta   ] = { of = ref }, -- ref is a reference to our expression containing the addition operator
}

addition_expression[meta] = {
  [expression] = {
    addition = r_addition,
    ...
  }
}
</pre>
---

<h1 style="text-align: center">Expression formalisms</h1>

---

# What is an expression
### At the abstract level:
* Composition of operators
* Defines the operators that are accepted within the expression

---

# What is an expression
### At the concrete level:
* A tree of sub-expressions

<pre style="font-size: 13px">
local literal_1 = {
  [refines] = { addition_expression },
  operator  = addition_expression[meta][expression].number,
  operands  = { 1 }
}

local literal_2 = {
  [refines] = { addition_expression },
  operator  = addition_expression[meta][expression].number,
  operands  = { 3 }
}

local addition_ = {
  [refines] = { addition_expression },
  operator  = addition_expression[meta][expression].addition,
  operands  = { literal1, literal2 }
}
</pre>
---

<img src="expression-tree.png" style="width: 100%">

----

