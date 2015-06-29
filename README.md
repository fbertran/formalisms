lua-layeredata
==============

--------------

Description
===========
lua-layeredata est une librairie qui permet de créer des calques

créer un calque: 

--    > Layer = require "layeredata"
--    > layer = Layer.new{ name = "layer"}
--    > = tostring(layer)
--    [[<layer>]]

créer un calque b qui dépend d'un calque a. Dépendre d'un calque signifie avoir besoin de lui pour exister.

--    > Layer = require "layeredata"
--    > a = Layer.new{ name = "a" }
--    > b = Layer.new{ name = "b" }
--    > b.__depends__ = { a }
--    > = a.__depends__, tostring(b.__depends__)
--    nil, "<b> [__depends__]"
un calque est une table, on peut donc lui ajouter des éléments.

--    > Layer = require "layeredata"
--    > a = Layer.new{ name = "a" }
--    > a.x = 1
--    > a.y = "y"
--    > a.z = {}
--    > = a.x, a.y, tostring(a.z), a.t
--    1, "y", "<a> [z]", nil

On peut également modifier ou compléter les éléments du calque a dans le calque b. Pour cela, b doit dépendre de a et le rafiner.

--    > Layer = require "layeredata"
--    > a = Layer.new{ name = "a" }
--    > a.z = {id = 1}
--    > b = Layer.new{ name = "b" }
--    > b.__depends__ = { a }
--    > b.z = {__refines__ = {a.z}}
--    > = tostring(a.z), tostring(b.z), a.z.id, b.z.id
--    "<a> [z]", "<b> [z]", 1, 1

Il est possible d'avoir des dépendances multiples

--    > Layer = require "layeredata"
--    > a = Layer.new{ name = "a" }
--    > b = Layer.new{ name = "b" }
--    > c = Layer.new{ name = "c" }
--    > d = Layer.new{ name = "d" }
--    > b.__depends__ = { a }
--    > c.__depends__ = { a }
--    > d.__depends__ = { b, c }
--    > = tostring(d.__depends__)
--    "<d> [__depends__]"

il est possible de créer des prototypes, pour cela on utilise 4 clés:
* key_type : le type de la clé (un autre prototype ou un type de base)
* content_type : le type de la valeur. 
* key_container : les éléments qui peuvent être utilisé comme clés.
* value_container : les éléments qui peuvent être utilisé comme valeur.

si une clé n'est pas renseigné ou si la valeur pour une de ces clés est nil, tout sera accepté. 

pour dire qu'un élément est de prototype "type", on le rafine de ce type.

--    > Layer = require "layeredata"
--    > a = Layer.new{ name = "a" }
--    > a.a_type = {
--    >   key_type = "string",
--    >   value_container = {1, "a", 5},
--    >   key_container =  nil, }
--    > a.x = {__refines__ = {a.a_type}, ["key"] = 1}


lorsque l'on veut creer un type il faut utiliser la clé __meta__, c'est également le cas lorsqu'on défini un type dans un autre type.

--    >--    > Layer = require "layeredata"
--    > a = Layer.new{ name = "a" }
--    > a.__meta__ = { a_type = { } 
