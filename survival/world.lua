function loadWorld()

	world = {}
	world.physics = love.physics.newWorld(0,0,true)
	world.x, world.y = 0, 0
	world.w, world.h = 500, 500
	world.bg = love.graphics.newImage('assets/island.png')
end

function getColour(x, y)
	--r,g,b,a = 0,0,0,0
	love.graphics.captureScreenshot(
		function(imageData)
			r, g, b, a = imageData:getPixel(x,y)
		end
	)
	return r
end

function drawWorld()
	-- for i = world.x, world.x+world.w / world.bg:getWidth() do
	-- 	for j = world.y, world.y+world.h / world.bg:getHeight() do
	-- 		love.graphics.draw(world.bg, i * world.bg:getWidth(), j * world.bg:getHeight())
	-- 	end
	-- end

	love.graphics.draw(world.bg, world.x, world.y, 0, 2, 2)
	--love.graphics.print(tostring(green), 0, 0)

	--trees?
	for i = 0, 10 do
		love.graphics.print(getColour(i, 0), i*10, 0)
	end
end

function updateWorld(dt)
	--world.x = world.x + 1 * dt
	if love.keyboard.isDown('w') then
		world.y = world.y + 100 * dt
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