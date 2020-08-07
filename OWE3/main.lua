io.stdout:setvbuf("no") -- live console for ST3

require 'world'

function love.load()
	sw, sh = love.graphics.getDimensions()

	World:load()
end

function love.draw()
	World:draw()
end

function love.update(dt)
	sw, sh = love.graphics.getDimensions()

	World:update(dt)
end

-- custom funcs
function col(x1,y1,w1,h1, x2,y2,w2,h2)
	if x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1 then
		return true
	else
		return false
	end
end