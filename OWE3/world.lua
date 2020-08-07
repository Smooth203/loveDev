World = {
	load = function(self)
			self.x = 0
			self.y = 0
			self.w = 1000
			self.h = 1000
			self.tileSize = 30
			self.tileDisplayW = sw/30
			self.tileDisplayH = sh/30
			self.world = {}
			self.tileCount = 0
			for x = 0, self.w-1 do
				self.world[x] = {}
				for y = 0, self.h-1 do
					self.tileCount = self.tileCount + 1
					self.world[x][y] = {
						id = self.tileCount,
						value = 0
					}
				end
			end
		end,

	draw = function(self)
			for x = 0, self.w-1 do
				for y = 0, self.h-1 do
					--love.graphics.rectangle('line', x*20, y*20, 20, 20)
				end
			end
		end,

	update = function (self, dt)
		--self.x = self.x - 1
	end,

	-- loadTiles = function(self)
	-- 	self.loadedTiles = {}
	-- 	local count = 0
	-- 	for x = 0, self.tileDisplayW do
	-- 		for y = 0, self.tileDisplayH do
	-- 			count = count + 1

	-- 			local tile = {}
	-- 			tile.id = count
	-- 			tile.x = x*self.tileSize
	-- 			tile.y = y*self.tileSize

	-- 			table.insert(self.loadedTiles, tile)
	-- 		end
	-- 	end
	-- end
}