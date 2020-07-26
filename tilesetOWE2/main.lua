io.stdout:setvbuf("no") -- live console for ST3

-- Gamestates - playing, paused, menu

-- World - world drawing and interactions
-- camera - manages terrain & entitiy movement on screen
-- Entities - players, enemies, anything that 'moves'

require 'require'

function love.load()
	gamestate = 'playing'
	cam.load()
	world.load()
	entities.load()
end

function love.draw()
	if gamestate == 'playing' then
		cam.draw()
		world.draw()
		entities.draw()
	elseif gamestate == 'paused' then

	elseif gamestate == 'menu' then

	end
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function love.update(dt)
	if gamestate == 'playing' then
		world.update(dt)
		entities.update(dt)
		cam.update(dt)
	elseif gamestate == 'paused' then

	elseif gamestate == 'menu' then

	end
end

function love.resize(w, h)

end

function love.mousepressed(x, y, button)
	cam.mousepressed(x,y,button)
end

function love.wheelmoved(x, y)
	cam.wheelmoved(x,y)
end