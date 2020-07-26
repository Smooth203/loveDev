-- 
-- cam w & h is screen w & h

cam = {
	load = function()
		cam.x, cam.y = 0, 0
		cam.speedX, cam.speedY, cam.maxSpeed = 0, 0, 100
	end,

	draw = function()
		--love.graphics.translate(cam.tx, cam.ty)
	end,

	update = function(dt)
		if love.keyboard.isDown('w') then
			cam.speedY = cam.maxSpeed
		elseif love.keyboard.isDown('s') then
			cam.speedY = -cam.maxSpeed
		else
			cam.speedY = 0
		end
		if love.keyboard.isDown('a') then
			cam.speedX = cam.maxSpeed
		elseif love.keyboard.isDown('d') then
			cam.speedX = -cam.maxSpeed
		else
			cam.speedX = 0
		end
	end,

	mousepressed = function(x, y, button)

	end,

	wheelmoved = function(x,y)

	end,

	-- Custom Functions
}