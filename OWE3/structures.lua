Structures = {}

local tree = require 'tree'

function newStructure(id, name, x, y)
	return Structures[name](id, x, y)
end

function getFuncs(name)
	return Structures[name].funcs()
end