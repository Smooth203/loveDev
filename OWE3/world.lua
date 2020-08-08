World = {
	get = function(self, p)
		if p == 'x' then
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
		end
	end,

	load = function(self)
		self.active = true
		self.Textures = require 'textures'
		self.tileset = love.graphics.newImage('assets/tileset.png')
		self.tileSize = 32

		self.x = -600
		self.y = -2000
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
		for x = 0, self.w do
			self.world[x] = {}
			for y = 0, self.h do
				local r = math.random(0, 100)
				local tex = 2
				if r == 0 then
					tex = 1
				elseif r == 4 then
					tex = 3
				end
				self.world[x][y] = {
					x = x,
					y = y,
					texture = tex
				}
			end
		end

		World:updateWorld()
	end,

	draw = function(self)
		love.graphics.draw(self.batch, math.floor(self.x), math.floor(self.y))
	end,

	update = function (self, dt)

	end,

	move = function(self, dx, dy)
		self.x = self.x + dx
		self.y = self.y + dy
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
		local tile = {x=-999,y=-999}
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

		for x = 0, self.w do
			for y = 0, self.h do
				local tile = self.world[x][y]
				id = self.batch:add(self.quads[tile.texture], x*self.tileSize, y*self.tileSize)
			end
		end

		self.batch:flush()
	end
}