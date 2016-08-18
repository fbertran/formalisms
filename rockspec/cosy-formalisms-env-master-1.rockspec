package = "cosy-formalisms-env"
version = "master-1"

source = {
  url = "git://github.com/CosyVerif/formalisms",
}

description = {
  summary     = "Formalisms for CosyVerif (development environment)",
  detailed    = [[]],
  license     = "MIT/X11",
  maintainer  = "Alban Linard <alban@linard.fr>",
}

dependencies = {
  "busted",
  "cluacov",
  "luacheck",
  "luacov",
  "luacov-coveralls",
}

build = {
  type    = "builtin",
  modules = {},
}
