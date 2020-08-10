local player = require 'player'
local Structures = require 'structures'
local Items = require 'items'

--entity types
-- / done, x not done
	-- player /
	-- structure /
	-- droppedItem x
	-- animal (mob?) x

Entities = {
	load = function(self)
		self.entities = {
			newPlayer('p1', sw/2, sh/2, 'wasd', love.graphics.newImage('assets/player.png'))
		}
		math.randomseed(os.time())
		for x = 0, World:get('w') do
			for y = 0, World:get('h') do
				local r = math.random(0, 100)
				if r == 0 then
					local id = love.timer.getTime()
					local tree, top = newStructure(id, 'tree', x, y)
					table.insert(self.entities, 1, tree)
					table.insert(self.entities, top)
				end
			end
		end
	end,

	draw = function(self)
		for i, e in ipairs(self.entities) do
			if e.draw() then
				e.draw()
			end
		end
		--love.graphics.rectangle('line', sw/3, sh/3, sw-2*(sw/3), sh-2*(sh/3))
	end,

	update = function(self, dt)
		for i, e in ipairs(self.entities) do
			if e.update then
				e.update(dt)
			end
		end
	end,

	action = function(self,x,y,button,equipped)
		local success = nil
		for i, e in ipairs(self.entities) do
			if e.action then
				success = pcall(e.action, x,y,button,equipped)
				if success then
					break
				end
			end
		end
		return success
	end,

	getEntity = function(self, id)
		for i, e in pairs(self.entities) do
			if e.id == id then
				return i
			end
		end
	end,

	removeEntity = function(self, id)
		local index = Entities:getEntity(id)
		table.remove(self.entities, index)
	end,

	dropItem = function(self, item, x, y)
		local Item = newItem(item,x,y)
		table.insert(self.entities, Item)
	end,

	getPlayer = function(self)
		for i, e in pairs(self.entities) do
			if e.name == 'p1' then
				return e
			end
		end
	end,

	mousepressed = function(self, x, y, button)
		for i, e in ipairs(self.entities) do
			if e.mousepressed then
				e.mousepressed(x,y,button)
			end
		end
	end
}