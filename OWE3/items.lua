items = {
	-- example = {
	-- 	name = 'Example',
	-- 	img = love.graphics.newImage('assets/example.png'),
	-- 	equip = {
	-- 		dmgMultiplier = 1,
	-- 		attackMultiplier = 1
	-- 	}
	-- },
	flower = {
		name = 'Flower',
		img = love.graphics.newImage('assets/flower.png'),
		equip = {
			dmgMultiplier = 25,
			attackMultiplier = 1
		}
	},
	wood = {
		name = 'Wood',
		img = love.graphics.newImage('assets/wood.png')
	}
}

function newItem(item, x, y)
	local itemData = items[item]
	local Item = {

		load = function(self)
			self.Type = 'item'
			self.id = love.timer.getTime()
			self.x = x
			self.y = y
			self.data = itemData
			self.tile = World:getTile(math.floor(((x)-World:get('x'))/World:get('tileSize')),math.floor(((y)-World:get('y'))/World:get('tileSize')))
			self.collisions = {
				inRadius = false
			}
		end,

		-- save = function(self)
		-- 	return self
		-- end,

		draw = function(self)
			love.graphics.draw(self.data.img, self.x, self.y, 0, 0.25, 0.25)
			if self.collisions.inRadius then
				love.graphics.rectangle('fill', self.x-20, self.y-30, 80, 25)
				love.graphics.setColor(0,0,0,1)
				love.graphics.print("Pick Up: 'E'", self.x-12.5, self.y-30)
				love.graphics.setColor(1,1,1,1)
			end
		end,

		update = function(self,dt)
			self.x, self.y = math.floor((World:get('x')+(self.tile.x*World:get('tileSize')))), math.floor(World:get('y')+(self.tile.y*World:get('tileSize')))
		end,

		keypressed = function(self,key)
			if key == 'e' and self.collisions.inRadius then
				print('pick')
				Ui:addItem(string.lower(self.data.name), 'inv')
				Entities:removeEntity(self.id)
			end
		end,

		collision = function(self,with)
			--within pickup radius
			if col(self.x-World:get('tileSize'),self.y-World:get('tileSize'),3*World:get('tileSize'),3*World:get('tileSize'), with.x,with.y,with.w,with.h) then
				self.collisions.inRadius = true
			else
				self.collisions.inRadius = false
			end
		end,
	}
	Item:load()
	return Item
end