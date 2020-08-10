Structures = {}

local tree = require 'tree'

function newStructure(id, name, x, y)
	return Structures[name](id, x, y)
end