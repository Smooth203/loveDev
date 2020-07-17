function loadPlayer()
	player = {
		pos = {
			x = 50,
			y = 50,
			w = 10,
			h = 10
		},
		centre = {
			x = 55,
			y = 55
		},
		img = nil,
		speed = 50,
		inVehicle = false
	}
end

function drawPlayer()
	love.graphics.rectangle('fill', player.pos.x, player.pos.y, 10, 10)
	love.graphics.print(player.centre.x .. " " .. player.centre.y, 0, 100)
end

function updatePlayer(dt)
	player.centre = {
		x = player.pos.x + player.pos.w/2,
		y = player.pos.y + player.pos.h/2,
	}
	if not player.inVehicle then
		if love.keyboard.isDown('w') then
			player.pos.y = player.pos.y - player.speed * dt
		end
		if love.keyboard.isDown('s') then
			player.pos.y = player.pos.y + player.speed * dt
		end
		if love.keyboard.isDown('d') then
			player.pos.x = player.pos.x + player.speed * dt
		end
		if love.keyboard.isDown('a') then
			player.pos.x = player.pos.x - player.speed * dt
		end
	end
end