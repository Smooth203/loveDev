local Noise = require 'noise'
local scale = 10

World = {
	get = function(self, p)
		if p == 'all' or p == nil then	
			local worldInfo = {
				{
					x = self.x,
					y = self.y,
					w = self.w,
					h = self.h
				},
				{
					tiles = self.world
				}
			}
			return worldInfo
		elseif p == 'x' then
			return self.x
		elseif p == 'y' then
			return self.y
		elseif p == 'w' then
			return self.w
		elseif p == 'h' then
			return self.h
		elseif p == 'tileSize' then
			return self.tileSize
		elseif p == 'tileset' then
			return self.tileset
		elseif p == 'batch' then
			return self.batch
		elseif p == 'heightmap' then
			return self.heightmap
		end
	end,

	load = function(self, world, info)
		self.x = info.x -- in terms of tiles
		self.y = info.y
		self.w = info.w
		self.h = info.h
		self.world = world
		
		self.active = true
		self.Textures = require 'textures'
		self.tileset = love.graphics.newImage('assets/tileset.png')
		self.batch = love.graphics.newSpriteBatch(self.tileset, self.w*self.h)
		self.tileSize = 32
		--quads
		self.quads = {}
		for _, texture in pairs(textures) do
			local t = texture
			self.quads[t.value] = love.graphics.newQuad(t.x*self.tileSize, t.y*self.tileSize, self.tileSize, self.tileSize, self.tileset:getWidth(), self.tileset:getHeight())
		end
		World:updateWorld()
	end,

	new = function(self)
		self.active = true
		self.Textures = require 'textures'
		self.tileset = love.graphics.newImage('assets/tileset.png')
		self.tileSize = 32

		self.x = 0
		self.y = 0
		self.w = 500
		self.h = 500
		self.world = {}
		self.tileCount = 0
		
		self.batch = love.graphics.newSpriteBatch(self.tileset, self.w*self.h)

		--quads
		self.quads = {}
		for _, texture in pairs(textures) do
			local t = texture
			self.quads[t.value] = love.graphics.newQuad(t.x*self.tileSize, t.y*self.tileSize, self.tileSize, self.tileSize, self.tileset:getWidth(), self.tileset:getHeight())
		end
		--WORLD GEN
		for x = 0, self.w do
			for y = 0, self.h do
				distX =	math.abs(x-(self.w * 0.5)-0)
				distY = math.abs(y-(self.h * 0.5)-0)
				dist = math.sqrt((distX*distX) + (distY*distY)) -- circular
				maxW = self.w * 0.5 - 10
				delta = dist / maxW
				gradient = delta * delta

				self.world[x] = self.world[x] or {}
				xCoord = x/self.w * scale
				yCoord = y/self.h * scale
				zCoord = scale
				self.heightmap = love.math.noise(xCoord+love.timer.getTime(),yCoord+love.timer.getTime(),zCoord)* pickMax(0, 1-gradient)
				local tex = 2
				if self.heightmap <= 0.26 then
					tex = 4 -- set water
				elseif self.heightmap > 0.26 and self.heightmap <= 0.3 then
					tex = 5 -- beach
				end
				if tex ~= 4 then
					local rn = love.math.random(1,100)
					if self.heightmap > 0.3 and self.heightmap < 0.5 then
						-- in grassland
						if rn == 1 then
							tex = 3 -- flowers
						elseif rn == 2 then
							tex = 6 -- small stone
						end
					elseif self.heightmap > 0.4 then
						--in inner land
						if rn == 1 then
							tex = 7 -- large stone
						end
					end
				end
				self.world[x][y] = {
					x = x,
					y = y,					
					texture = tex,
				}
			end
		end
		World:updateWorld()
	end,

	draw = function(self)
		love.graphics.draw(self.batch, math.floor(self.x), math.floor(self.y), 0,  1, 1)
		--slove.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
	end,

	update = function (self, dt)

	end,

	move = function(self, dx, dy)
		self.x = self.x + dx
		self.y = self.y + dy
	end,

	moveTo = function(self, x, y)
		self.x = x
		self.y = y
	end,

	getTile = function(self, tx, ty)
		for x = 0, self.w do
			if x == tx then
				for y = 0, self.h do
					if y == ty then
						if x >= 0 and y >= 0 then
							local tile = self.world[tx][ty]
							return tile
						end
					end
				end
			end
		end
		local tile = {x=-9999999,y=-9999999}
		return tile
	end,

	setTile = function(self, tx, ty, to)
		for x = 0, self.w do
			if x == tx then
				for y = 0, self.h do
					if y == ty then
						if x >= 0 and y >= 0 then
							self.world[tx][ty].texture = to
							World:updateWorld()
						end
					end
				end
			end
		end
	end,

	updateWorld = function (self)
		self.batch:clear()

		for x = 1, self.w do
			for y = 1, self.h do
				local tile = self.world[x][y]
				id = self.batch:add(self.quads[tile.texture], x*self.tileSize, y*self.tileSize)
			end
		end

		self.batch:flush()
	end
}