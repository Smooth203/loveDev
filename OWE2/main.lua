io.stdout:setvbuf("no") -- live console for ST3

-- Gamestates - playing, paused, menu

-- Terrain - world drawing and interactions
-- camera - manages terrain & entitiy movement on screen
-- Entities - players, enemies, anything that 'moves'

require 'require'

function love.load()
	gamestate = 'playing'
	terrain.load()
	entities.load()
end

function love.draw()
	if gamestate == 'playing' then
		terrain.draw()
		--entities.update()
	elseif gamestate == 'paused' then

	elseif gamestate == 'menu' then

	end
end

function love.update(dt)
	if gamestate == 'playing' then
		terrain.update(dt)
		--entities.update(dt)
	elseif gamestate == 'paused' then

	elseif gamestate == 'menu' then

	end
end

function love.resize(w, h)

end