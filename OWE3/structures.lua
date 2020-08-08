structures = {
	{
		name = 'tree',
		x = 12,
		y = 16,
		w = 3,
		h = 2
	}
}

function newStructure(name, x, y)
	for _, s in pairs(structures) do
		if s.name == name then
			local structure = {}
			structure.quad = love.graphics.newQuad(s.x*World:get('tileSize'), s.y*World:get('tileSize'), s.w*World:get('tileSize'), s.h*World:get('tileSize'), World:get('tileset'):getWidth(), World:get('tileset'):getHeight())
			structure.x = x
			structure.y = y
			structure.w = s.w
			structure.h = s.h

			function structure.draw()
				love.graphics.draw(World:get('tileset'), structure.quad,
					math.floor(World:get('x')+(structure.x*World:get('tileSize'))),
					math.floor(World:get('y')+(structure.y*World:get('tileSize')))
					)
			end
			function structure.update(dt)

			end
			function structure.mousepressed(x,y,button)

			end

			return structure
		end
	end
end