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

# Most important feature
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
        value_type = re.operator [meta].of, -- re will be a reference to the expression instance
                                            -- containing this operator
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

# Existing lexical analyser generators
* ANTLR
* Flex/Bison
* PEGjs
* LPeg
* LulPeg

---

# Choice: LPeg
* Allows grammar composition
* Can parse context-free grammars
* Convenient LUA integration

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
<pre style="font-size: 20px;">
&lt;Number&gt; ::= [0-9]+
</pre>
And add it to the grammar
<pre style="font-size: 20px;">
&lt;P15&gt; ::= &lt;Number&gt;
</pre>

---

# Example
Then the multiplication rule
<pre style="font-size: 20px;">
&lt;Multiplication&gt; ::= &lt;P15&gt; '*' (&lt;P12&gt; | &lt;P15&gt;)
</pre>
And add it to the grammar
<pre style="font-size: 20px;">
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
1. Literals and n-ary operators must have highest priority.
2. If our expression allows variables, they must be added last.
3. Patterns have been created for the most common operator types; if other types are needed, the pattern must be defined for the parser to accept it.

---

# Problem with PEG parsers

### They can't handle left recursion

---

# Why is this a problem?
### No left recursion -> no "native" solution for left-associative operators

---

# Why is this a problem

An expression such as <pre style="font-size: 13px">1 + 2 + 3</pre> will always be parsed into
<pre style="font-size:13px">{ 1 + { 2 + 3 } }</pre>
by LPeg

---

# Solution

Assuming our <code>'+'</code> operator is left-associative, once LPeg has produced the  table

<pre style="font-size: 13px">{ 1 + { 2 + 3 } }</pre>

we can simply operate on it in a recursive fashion to obtain what we want, i.e.

<pre style="font-size: 13px">{ { 1 + 2 } + 3 }</pre>