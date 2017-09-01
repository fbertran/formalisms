<!-- footer: Lars Gabriel Annell Rydenvald --->
<!-- page_number: true -->

<style type="text/css">
	pre, code { font-size: 16px !important;  }
</style>

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

# Most important feature
* Modularity

--- 

# Achieving modularity

Let the expression that uses the operator model define the type of the operands

---

# Example - Addition operator

```lua
addition [meta] = {
  operands = {
    [refines] = { collection },
    [meta   ] = {
      [collection] = {
        minimum    = 2,
        maximum    = 2,
        value_type = re.operator [meta].of, -- re will be a reference to 
                                            -- the expression instance
                                            -- containing this operator
      },
    },
  },
}
```

---

# Example - Addition operator
### Using it in an expression
The type of the operands are defined here
```lua
local r_addition = {
  [refines] = { addition },
  [meta   ] = { of = ref }, -- ref is a reference to our expression 
                            -- containing the addition operator
}

addition_expression[meta] = {
  [expression] = {
    addition = r_addition,
    ...
  }
}
```
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

```lua
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
```

---

<img src="expression-tree.png" style="width: 100%">

----

# Unfortunately
In practice, this approach does not work.

---

# Problem

Defining the type of an operand as an expression -> infinite loop. Layeredata should be able to handle this case, but it isn't.

--- 

# Solution

N/A

---

<h1 style="text-align: center;">Grammar generation and parsing</h1>

---

# Problem to solve
Operators and expressions not known beforehand

---

# Some existing lexical analyser generators
* ANTLR
* Flex/Bison
* PEGjs
* LPeg
* LulPeg

---

# Choice: LPeg
* Allows grammar composition
* Convenient LUA integration

---

# Why not LulPeg?
Too slow: parsing <code style="font-size: 25px !important;">(((((sum(30-20))))))</code> takes over 3 minutes for LulPeg, around 2 seconds for LPeg

---


# Generating a grammar from operators

1) Sort by operator priority (descending)
2) Use predetermined patterns for each operator
3) Add the pattern to the grammar

---

# Example

<table>
	<tr style="width: 100%;">
    	<th style="width: 2%;">Operator</th>
        <th style="width: 2%;">Priority</th>
        <th style="width: 2%;">Type</th>
        <th style="width: 2%;">Representation</th>
	</tr>
    <tr>
    	<td style="text-align: center;">Addition</td>
        <td style="text-align: center;">11</td>
        <td style="text-align: center;">binary</td>
        <td style="text-align: center;">'+'</td>
	</tr>
    <tr>
    	<td style="text-align: center;">Substraction</td>
        <td style="text-align: center;">11</td>
        <td style="text-align: center;">binary</td>
        <td style="text-align: center;">'-'</td>
	</tr>
    <tr>
    	<td style="text-align: center;">Multiplication</td>
        <td style="text-align: center;">12</td>
        <td style="text-align: center;">binary</td>
        <td style="text-align: center;">'*'</td>
	</tr>
    <tr>
    	<td style="text-align: center;">Number</td>
        <td style="text-align: center;">15</td>
        <td style="text-align: center;">literal</td>
        <td style="text-align: center;">[0-9]+</td>
	</tr>
</table>

---

# Example
First we create the literal / terminal rule
<pre style="font-size:20px !important;">
&lt;Number&gt; ::= [0-9]+
</pre>
And add it to the grammar
<pre style="font-size: 20px !important;">
&lt;P15&gt; ::= &lt;Number&gt;
</pre>

---

# Example
Then the multiplication rule
<pre style="font-size: 20px !important;">
&lt;Multiplication&gt; ::= &lt;P15&gt; '*' (&lt;P12&gt; | &lt;P15&gt;)
</pre>
And add it to the grammar
<pre style="font-size: 20px !important;">
&lt;P12&gt; ::= &lt;Multiplication&gt; | &lt;P15&gt;
&lt;P15&gt; ::= &lt;Number&gt;
</pre>

---

# Example
Then repeat for the addition and substraction operators
<pre style="font-size: 20px;">
&lt;Addition&gt;     ::= &lt;P12&gt; '+' (&lt;P11&gt; | &lt;P12&gt;)
&lt;Substraction&gt; ::= &lt;P12&gt; '-' (&lt;P11&gt; | &lt;P12&gt;)
</pre>
And our grammar finally looks like this
<pre style="font-size: 20px;">
&lt;S&gt;   ::= &lt;P11&gt;
&lt;P11&gt; ::= &lt;Addition&gt; | &lt;Substraction&gt; | &lt;P12&gt;
&lt;P12&gt; ::= &lt;Multiplication&gt; | &lt;P15&gt;
&lt;P15&gt; ::= &lt;Number&gt;
</pre>

---

# Some considerations
1. Literals and n-ary operators should have the highest priority of the different operators.
2. If our expression allows variables, they must be added last.
3. Patterns have been created for the most common operator types; if other types are needed, the pattern must be defined for the parser to be able to handle it.

---

# Problem with LPeg

## It doesn't accept left recursion

---

# Why is this a problem?

No left recursion &rArr; no "native" solution for left-associative binary operators

---

# Why is this a problem

An input such as <pre>1 + 2 + 3</pre> will always be parsed into
<pre>{ 1 + { 2 + 3 } }</pre>
by LPeg, while we might want
<pre>{ { 1 + 2 } + 3 }</pre>

---

# Solution

Assuming our <code>addition</code> operator is left-associative, once LPeg has produced the  table

<pre>{ 1 + { 2 + 3 } }</pre>

we can simply operate on it in a recursive fashion to obtain what we want, i.e.

<pre>{ { 1 + 2 } + 3 }</pre>

---

# How to create a pattern for a new operator type

1.  Decide on operator type name, e.g. *quaternary*
2.  Create the pattern
```lua
local pattern = (
  next_expr * white * first * white *
  lp.V("axiom") * white * second * white *
  lp.V("axiom") * white * third * white * (curr_expr + next_expr)
)
```
3. Create a capture function, can be as simple as just returning a table
4. Insert into our `patterns` table

---

# How to create a pattern for a new operator type

Example of a capture function for our *quaternary* operator
```lua
-- p is the pattern from the last slide
function quaternary_capture (p)
  -- We use LPegs capture and apply function operator ( / )
  return p / function (left, op1, middle1, op2, middle2, op3, right)
    -- And we basically return a table
    -- We could just use LPeg.Ct (capture table)
    -- However if we need to define the keys of our table,
    -- we can't use that function, since LPeg.Ct returns a table
    -- with numbers as keys
    return {
      left    = left,
      op      = op1,
      op2     = op2,
      op3     = op3,
      middle1 = middle1,
      middle2 = middle2,
      right   = right,
      op_type = "quaternary"
    }
  end
end
```

--- 

# How to create a pattern for a new operator type

When all this is done, we add it to our <code style="font-size:25px !important">patterns</code> table (in parser.lua)

---

It should look like this

```lua
local patterns = {
  ...,
  quaternary = function (operator, curr_expr, next_expr)
    -- We start by getting the textual representations
    -- of the operator
    local first, second, third = lp.P(operator.operator),
      lp.P(operator.operator1), lp.P(operator.operator2)
      
    -- We tell LPeg to capture these represantions (tokens)
    first = lp.C(first)
    second = lp.C(second)
    third = lp.C(third)
    
    -- Create the pattern
    local pattern = (
      next_expr * white * first * white *
      lp.V("axiom") * white * second * white * lp.V("axiom") * white *
      third * white * (curr_expr + next_expr)
    )
    
    -- Return the capture function
    return quaternary_capture(pattern)
  end,
  ...
}
```

<code style="font-size:25px!important">operator</code> is the operator object, <code style="font-size:25px!important">curr_expr</code> references the operator's level in the grammar, and <code style="font-size:25px!important">next_expr</code> is the level above.

