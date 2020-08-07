World = {
	load = function(self)
			self.x = 0
			self.y = 0
			self.w = 100
			self.h = 100
			self.tileSize = 30
			self.tileDisplayW = sw/30
			self.tileDisplayH = sh/30
			self.world = {}
			for x = 0, self.w do
				self.world[x] = {}
				for y = 0, self.h do
					self.world[x][y] = 0
				end
			end
			World:updateTiles()
		end,

	draw = function(self)
			for i, tile in ipairs(self.loadedTiles) do
				love.graphics.print(tile.id, tile.x*self.tileSize, tile.y*self.tileSize)
			end
		end,

	update = function (self, dt)
		--self.x = self.x + 1
		World:updateTiles()
	end,

	updateTiles = function(self)
		self.loadedTiles = {}
		local count = 0
		for x = 0, self.tileDisplayW do
			for y = 0, self.tileDisplayH do
				count = count + 1

				local tile = {}
				tile.id = count
				tile.x = x
				tile.y = y

				table.insert(self.loadedTiles, tile)
			end
		end
	end
}