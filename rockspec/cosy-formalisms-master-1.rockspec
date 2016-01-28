package = "cosy-formalisms"
version = "master-1"

source = {
  url = "git://github.com/CosyVerif/formalisms",
}

description = {
  summary     = "Formalisms for CosyVerif",
  detailed    = [[]],
  license     = "MIT/X11",
  maintainer  = "Alban Linard <alban@linard.fr>",
}

dependencies = {
  "coronest",
  "layeredata",
}

build = {
  type    = "builtin",
  modules = {
    ["cosy.formalism"                     ] = "src/cosy/formalism/init.lua",
    ["cosy.formalism.data.record"         ] = "src/cosy/formalism/data/record.lua",
    ["cosy.formalism.data.collection"     ] = "src/cosy/formalism/data/collection.lua",
    ["cosy.formalism.data.check_container"] = "src/cosy/formalism/data/check_container.lua",
    ["cosy.formalism.data.check_type"     ] = "src/cosy/formalism/data/check_type.lua",
  },
}
