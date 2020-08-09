Structures = {}

local tree = require 'tree'

function newStructure(name, x, y)
	return Structures[name](x, y)
end