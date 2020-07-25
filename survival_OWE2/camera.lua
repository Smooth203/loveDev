-- 
-- cam w & h is screen w & h

cam = {
	load = function()
		cam.x, cam.y = 0, 0
		cam.tx, cam.ty = 0, 0
		cam.cx, cam.cy = cam.getScreen('centre')
		cam.w, cam.h = cam.getScreen('size')
		cam.zoom = 1
	end,

	draw = function()
		love.graphics.translate(cam.tx, cam.ty)
		love.graphics.scale(cam.zoom, cam.zoom)
	end,

	update = function(dt)

	end,

	mousepressed = function(x, y, button)
		if button == 3 then
			cam.zoom = 1
			cam.doZoom()
		end
	end,

	wheelmoved = function(x,y)
		if y > 0 and cam.zoom < 2 then
			cam.zoom = cam.zoom + 0.1
		elseif y < 0 and cam.zoom > 0.6 then
			cam.zoom = cam.zoom - 0.1
		end
		cam.doZoom()
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
	end,

	doZoom = function()
		ox, oy = love.graphics.getWidth(), love.graphics.getHeight() --gets orig w & h of screen
		zx, zy = ox*cam.zoom, oy*cam.zoom --zooms
		cam.tx, cam.ty = (ox-zx)/2, (oy-zy)/2 --how much to offset
	end
}