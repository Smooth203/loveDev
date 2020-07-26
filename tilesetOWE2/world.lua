world = {
	load = function()
		world.tiles = {}
		world.x, world.y = 0, 0
		world.tileSize = 20
		world.w, world.h = 1000, 1000
		world.colour = function() return 0, 0.4, 0, 1 end

		tilesetImg = love.graphics.newImage('assets/tileset.png')
		tilesetImg:setFilter("nearest", "linear")
		tileSize = 32
		tileDisplaySize = 20
		tileQuads = {}
		tileQuads[0] = love.graphics.newQuad(6*tileSize, 17*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
		tilesetBatch = love.graphics.newSpriteBatch(tilesetImg, tileDisplaySize * tileDisplaySize)

		tilesetBatch:clear()
		for x=0, tileDisplaySize-1 do
			for y=0, tileDisplaySize-1 do
		    	tilesetBatch:add(tileQuads[map[x+math.floor(mapX)][y+math.floor(mapY)]],
		    	x*tileSize, y*tileSize)
			end
		end
		tilesetBatch:flush()

		for x = 0, world.w/world.tileSize do
			for y = 0, world.h/world.tileSize do
				tile = {}
				tile.x, tile.y = x, y
				tile.w, tile.h = world.tileSize, world.tileSize
				tile.colour = function() return 0,0.75,0,1 end
				table.insert(world.tiles, tile)
				print(tile.x)
			end
		end
	end,

	draw = function()
		love.graphics.draw(tilesetBatch)
		-- for i, tile in pairs(world.tiles) do
		-- 	if tile.x < love.graphics.getWidth() and tile.y < love.graphics.getHeight() then
		-- 		love.graphics.setColor(tile.colour())
		-- 		love.graphics.rectangle('line', world.x+tile.x*tile.w, world.y+tile.y*tile.h, tile.w, tile.h)
		-- 	end
		-- end
		love.graphics.setColor(1,1,1,1)
	end,

	update = function(dt)
		world.x = world.x + cam.speedX * dt
		world.y = world.y + cam.speedY * dt
	end
}