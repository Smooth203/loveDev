io.stdout:setvbuf("no") -- live console for ST3

require 'world'
require 'entities'
require 'ui'

function love.load()
	sw, sh = love.graphics.getDimensions()
	love.graphics.setDefaultFilter('nearest', 'linear')
	math.randomseed(os.time())

	World:load()
	Entities:load()
	Ui:load()
end

function love.draw()
	World:draw()
	Entities:draw()
	Ui:draw()

	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
end

function love.update(dt)
	sw, sh = love.graphics.getDimensions()

	World:update(dt)
	Entities:update(dt)
	Ui:update(dt)
end

function love.mousepressed(x,y,button)
	Entities:mousepressed(x,y,button)
	Ui:mousepressed(x,y,button)
end

-- custom funcs
function col(x1,y1,w1,h1, x2,y2,w2,h2)
	if x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1 then
		return true
	else
		return false
	end
end