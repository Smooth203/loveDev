-- 
-- cam w & h is screen w & h

cam = {
	new = function()
		cam.x, cam.y = 0, 0
		cam.cx, cam.cy = cam.getScreen('centre')
		cam.w, cam.h = cam.getScreen('size')
	end,

	draw = function()

		love.graphics.rectangle('line', cam.x-5, cam.y-5, cam.w, cam.h)
		--love.graphics.rectangle('line', cam.x-cam.x, cam.y-cam.y, cam.w, cam.h)
	end,

	update = function(dt)

	end,

	-- Custom Functions
	getScreen = function(get)
		if get == 'centre' then
			return love.graphics.getWidth()/2, love.graphics.getHeight()/2
		elseif get == 'size' then
			return love.graphics.getWidth(), love.graphics.getHeight()
		else
			cam.cx, cam.cy = cam.getScreen('centre')
			cam.w, cam.h = cam.getScreen('size')
		end
	end
}