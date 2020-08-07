io.stdout:setvbuf("no") -- live console for ST3

function love.load()
	tileSize = 32

	world = {}


	love.math.getRandomSeed(os.time())
	for x = 0, 1000 do
		world[x] = {}
		for y = 0, 1000 do
			world[x][y] = math.random(0,3)
		end
	end
end

function love.draw()
	for i, tile in ipairs(world) do
		--	end
end

function love.update(dt)

end