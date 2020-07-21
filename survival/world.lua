function loadWorld()

	world = {}
	world.time = {
		full = 0000,
		hour = 12,
		minute = 0
	}
	world.physics = love.physics.newWorld(0,0,true)
	world.x, world.y = 0, 0
	world.w, world.h = 1000, 1000
	world.bgImg = love.graphics.newImage('assets/grass.jpg')
	world.bgImg:setWrap("repeat", "repeat")
	world.bgQuad = love.graphics.newQuad(0, 0, world.w, world.h, world.bgImg:getWidth(), world.bgImg:getHeight())
end

function worldColour()
	if world.time.hour >= 6 and world.time.hour <= 9 then
		return 0.388, 0.145, 0.129, 0.2
	elseif world.time.hour >= 10 and world.time.hour <= 17 then
		return 1, 1, 1, 0
	elseif world.time.hour >= 18 and world.time.hour <= 21 then
		return 0.388, 0.145, 0.129, 0.2
	elseif world.time.hour >= 22 or world.time.hour <= 5 then
		return 0.039, 0.039, 0.143, 0.4
	else
		return 1,1,1,1
	end
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
	love.graphics.draw(world.bgImg, world.bgQuad, world.x, world.y)
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

	--time
	world.time.minute = world.time.minute + dt
	if world.time.minute >= 60 then
		world.time.hour = world.time.hour + 1
		world.time.minute = 0
	end
	if world.time.hour > 23 then
		world.time.hour = 0
	end
	if world.time.minute < 10 then
		world.time.full = world.time.hour .. ":" .. "0" .. math.floor(world.time.minute)
	else
		world.time.full = world.time.hour .. ":" ..  math.floor(world.time.minute)
	end
end