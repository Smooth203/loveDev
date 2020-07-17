function loadWorld()

	world = {}
	world.physics = love.physics.newWorld(0,0,true)
	world.x, world.y = 0, 0
	world.w, world.h = 500, 500
	world.bg = love.graphics.newImage('assets/island.png')

	p,q = 0,0

end

function getColour(x, y)
	r, g, b, a = 0, 0, 0, 0
	love.graphics.captureScreenshot(
		function(imageData)
			cap = imageData:encode('png', 'cap')
		end
	)
	return r, g, b, a
end

function drawWorld()
	-- for i = world.x, world.x+world.w / world.bg:getWidth() do
	-- 	for j = world.y, world.y+world.h / world.bg:getHeight() do
	-- 		love.graphics.draw(world.bg, i * world.bg:getWidth(), j * world.bg:getHeight())
	-- 	end
	-- end

	love.graphics.draw(world.bg, world.x, world.y, 0, 2, 2)
	love.graphics.print(p .. " " .. q, 0, 0)

	--trees
end

function updateWorld(dt)
	--world.x = world.x + 1 * dt
	if love.keyboard.isDown('w') then
		--world.y = world.y + 100 * dt
		getColour(10, 10)
	end
	if love.keyboard.isDown('s') then
		world.y = world.y - 100 * dt
	end
	if love.keyboard.isDown('d') then
		world.x = world.x - 100 * dt
	end
	if love.keyboard.isDown('a') then
		world.x = world.x + 100 * dt
	end
end