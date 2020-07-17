function newVehicle(x, y)
	vehicle = {}

	vehicle.occupied = false
	vehicle.bounds = {
		x1 = x - 50,
		y1 = y - 25/2 - 25,
		w = 100,
		h = 75
	}
	vehicle.engineOn = true
	vehicle.playerNearby = false

	vehicle.speed = 0
	vehicle.turn = 0
	vehicle.turnMultiplier = 0

	vehicle.body = love.physics.newBody(world, x, y, 'dynamic')
	vehicle.shape = love.physics.newRectangleShape(50, 25)
	vehicle.fixture = love.physics.newFixture(vehicle.body, vehicle.shape, 1)
	table.insert(vehicles, vehicle)
end

function loadVehicles()
	vehicles = {}
	newVehicle(250, 250)
end

function drawVehicles()
	for vehicle in pairs(vehicles) do
		love.graphics.polygon('fill', vehicles[vehicle].body:getWorldPoints(vehicles[vehicle].shape:getPoints()))
		--love.graphics.rectangle('line', vehicles[vehicle].bounds.x1, vehicles[vehicle].bounds.y1, vehicles[vehicle].bounds.w, vehicles[vehicle].bounds.h)
		love.graphics.print(tostring(vehicles[vehicle].occupied) .. " " .. tostring(vehicles[vehicle].playerNearby), 0, 0)
	end
	love.graphics.setColor(1,1,1)
end

function updateVehicles(dt)
	for vehicle in pairs(vehicles) do
		vehicle = vehicles[vehicle]
		vehicle.playerNearby = col(vehicle.bounds.x1, vehicle.bounds.y1, vehicle.bounds.x1+vehicle.bounds.w, vehicle.bounds.y1+vehicle.bounds.h, player.centre.x , player.centre.y, player.centre.x , player.centre.y)
		if vehicle.playerNearby then
			if love.keyboard.isDown('e') then
				vehicle.occupied = true
				player.inVehicle = true
			end
		end
		if vehicle.occupied then

			vehicle.vx, vehicle.vy = vehicle.body:getLinearVelocity()
			vehicle.x, vehicle.y = vehicle.body:getWorldPoints(vehicle.shape:getPoints())
			vehicle.resultantSpeed = math.sqrt((vehicle.vx*vehicle.vx)+(vehicle.vy*vehicle.vy))
			vehicle.dirAng = math.acos(vehicle.vx/vehicle.resultantSpeed)
			vehicle.bounds = {
				x1 = vehicle.x - 50,
				y1 = vehicle.y - 25/2 - 25,
				w = 100,
				h = 75
			}

			if (vehicle.dirAng < math.pi/2) or (vehicle.dirAng > 3*math.pi/2) then
				vehicle.dir = -1
			else
				vehicle.dir = 1
			end

			vehicle.body:setLinearVelocity(vehicle.speed*math.cos(vehicle.body:getAngle()), vehicle.speed*math.sin(vehicle.body:getAngle()))
			vehicle.body:setAngle(vehicle.turn)

			if love.keyboard.isDown('w') and vehicle.engineOn then
				 if vehicle.speed < 100 then
					vehicle.speed = vehicle.speed + 100 * dt
				end
			elseif love.keyboard.isDown('s') and vehicle.engineOn then
				if vehicle.speed > -50 then
					vehicle.speed = vehicle.speed - 100 * dt
				end
			else
				if vehicle.speed > 0.1 then
					vehicle.speed = vehicle.speed - 100 * dt
				elseif vehicle.speed < -0.1 then
					vehicle.speed = vehicle.speed + 100 * dt
				else
					vehicle.speed = 0
				end
			end

			if math.abs(vehicle.speed) > 0 then
				vehicle.turn = vehicle.turn + 1 * dt * (vehicle.speed/100) * vehicle.turnMultiplier

				if love.keyboard.isDown('d') and vehicle.turnMultiplier <= 1 then
					vehicle.turnMultiplier = vehicle.turnMultiplier + 1 * dt
				elseif love.keyboard.isDown('a') and vehicle.turnMultiplier >= -1 then
				    vehicle.turnMultiplier = vehicle.turnMultiplier - 1 * dt
				else
					if vehicle.turnMultiplier > 0.1 then
						vehicle.turnMultiplier = vehicle.turnMultiplier - 1 * dt
					elseif vehicle.turnMultiplier < -0.1 then
						vehicle.turnMultiplier = vehicle.turnMultiplier + 1 * dt
					else
						vehicle.turnMultiplier = 0
					end
				end
			end
		else
			if vehicle.speed > 0.1 then
				vehicle.speed = vehicle.speed - 100 * dt
			elseif vehicle.speed < -0.1 then
				vehicle.speed = vehicle.speed + 100 * dt
			else
				vehicle.speed = 0
			end
			vehicle.body:setLinearVelocity(vehicle.speed*math.cos(vehicle.body:getAngle()), vehicle.speed*math.sin(vehicle.body:getAngle()))
		end
	end
end