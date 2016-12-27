package = "ardoises-formalisms-env"
version = "master-1"

source = {
  url = "git://github.com/ardoises/formalisms",
}

description = {
  summary     = "Ardoises: formalisms dev dependencies",
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
