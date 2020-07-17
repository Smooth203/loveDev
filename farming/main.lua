require "requires"

function col(x1, y1, x2, y2, X1, Y1, X2, Y2)
	if x1 < X1 and y1 < Y1 and x2 > X2 and y2 > Y2 then
		return(true)
	else
		return(false)
	end
end

function love.load()
	world = love.physics.newWorld(0,0,true)

	loadVehicles()
	loadPlayer()
end

function love.update(dt)
	world:update(dt)

	updatePlayer(dt)
	updateVehicles(dt)
end

function love.draw()
	drawVehicles()
	drawPlayer()
end