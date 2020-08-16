local player = require 'player'
local Structures = require 'structures'
local Items = require 'items'

--entity types
-- / done, x not done
	-- player /
	-- structure /
	-- droppedItem /
	-- animal (mob?) x

Entities = {

	get = function(self)
		return self.entities
	end,

	load = function(self, e)
		self.entities = e
		for i, e in ipairs(self.entities) do
			if e.Type == 'structure' then
				structures.getUnsaveables(e, e.name)
			elseif e.Type == 'player' then
				player_getUnsaveables(e)
			end
		end
	end,

	new = function(self)
		self.entities = {
			newPlayer('p1', sw/2, sh/2, 'wasd', 'assets/player.png')
		}
		math.randomseed(os.time())
		for x = 0, World:get('w') do
			for y = 0, World:get('h') do
				if World:getTile(x,y).texture == 2 then
					local r = math.random(0, 100)
					if r == 0 then
						local id = love.timer.getTime()
						local tree, top = newStructure(id, 'tree', x, y)
						table.insert(self.entities, 1, tree)
						table.insert(self.entities, top)
					end
				end
			end
		end
	end,

	draw = function(self)
		for i, e in ipairs(self.entities) do
			if e.draw then
				e:draw()
			end
		end
		--love.graphics.rectangle('line', sw/3, sh/3, sw-2*(sw/3), sh-2*(sh/3))
	end,

	update = function(self, dt)
		for i, e in ipairs(self.entities) do
			if e.update then
				e:update(dt)
			end
			if e.collision then
				e:collision(Entities:getPlayer())
			end
		end
	end,

	keypressed = function(self, key)
		for i, e in ipairs(self.entities) do
			if e.keypressed then
				e:keypressed(key)
			end
		end
	end,

	action = function(self,x,y,button,equipped)
		local success = nil
		for i, e in ipairs(self.entities) do
			if e.action then
				success = pcall(e.action, self,x,y,button,equipped)
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

	dropItem = function(self, item, x, y, quant)
		local Item = newItem(item,x,y, quant)
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
				e:mousepressed(x,y,button)
			end
		end
	end
}