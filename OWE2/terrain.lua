terrain = {
	load = function()
		terrain.x, terrain.y = 0, 0
		terrain.w, terrain.h = 500, 500
		terrain.colour = function() return 0, 0.4, 0, 1 end
	end,

	draw = function()
		love.graphics.setColor(terrain.colour())
		love.graphics.rectangle('fill', terrain.x, terrain.y, terrain.w, terrain.h)
		love.graphics.setColor(1,1,1,1)
	end,

	update = function()
	
	end
}