require 'requires'

function col(x1, y1, x2, y2, X1, Y1, X2, Y2)
	if x1 < X1 and y1 < Y1 and x2 > X2 and y2 > Y2 then
		return(true)
	else
		return(false)
	end
end

function love.load()
	
	loadWorld()

end

function love.draw()

	drawWorld()

end

function love.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.quit()
	end

	updateWorld(dt)
	
end