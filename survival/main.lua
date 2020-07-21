require 'requires'

function col(x1, y1, x2, y2, X1, Y1, X2, Y2)
	if x1 < X1 and y1 < Y1 and x2 > X2 and y2 > Y2 then
		return(true)
	else
		return(false)
	end
end

function pause()
	if paused then
		paused = false
	else
		paused = true
	end
end

function love.load()

	loadWorld()
	loadPlayer()
	loadTrees()
	loadAlert()
	loadUI()

	paused = false
	zoom = 1

end

function love.draw()
	love.graphics.setDefaultFilter('nearest', 'nearest', 1)
	love.graphics.scale(zoom, zoom)
	
	drawWorld()
	drawPlayer()
	drawTrees()
	love.graphics.setColor(worldColour())
	love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setColor(1,1,1,1)

	drawAlert()
	drawUI()
	-- 1m guide
	--love.graphics.rectangle('fill', (love.graphics.getWidth()/2)-16, (love.graphics.getHeight()/2)-16, 24, 24)

end

function love.update(dt)
	if love.keyboard.isDown('f12') then
		love.event.quit()
	end

	if not paused then
		updateWorld(dt)
		updatePlayer(dt)
		updateTrees(dt)
		updateAlert(dt)
		updateAlert(dt)
	end

	updateUI(dt)
end

function love.keypressed(key)
	keypressedUI(key)
end