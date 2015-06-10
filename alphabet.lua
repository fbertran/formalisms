--alphabet
package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local repository = Repository.new()

Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.alphabet = {
  alphabet_type = {
    symbol_type = {},
    symbols = {},
  },
}
    
return repository.alphabet
