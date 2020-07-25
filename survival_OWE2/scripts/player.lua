entities.types.players = {

	list = {},

	new = function(entity)
		player = {
			x = entity.x,
			y = entity.y,
			w = entity.w,
			h = entity.h,
			img = entity.img,
			speed = 100
		}
		table.insert(entities.types.players.list, player)
	end,

	draw = function()
		if player.img == nil then
			love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
		else
			love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, player.w/2, player.h/2)
		end
		print(player.x .. ", " .. player.y)
	end,

	update = function(dt)

		entities.types.players.controls(dt)
	
	end,

	controls = function(dt)
		for i, player in pairs(entities.types.players.list) do
			if love.keyboard.isDown('w') then
				player.y = player.y - 1 * player.speed * dt
				cam.ty = cam.ty + 1 * player.speed * dt
			elseif love.keyboard.isDown('s') then
				player.y = player.y + 1 * player.speed * dt
				cam.ty = cam.ty - 1 * player.speed * dt
			end
			if love.keyboard.isDown('a') then
				player.x = player.x - 1 * player.speed * dt
				cam.tx = cam.tx + 1 * player.speed * dt
			elseif love.keyboard.isDown('d') then
				player.x = player.x + 1 * player.speed * dt
				cam.tx = cam.tx - 1 * player.speed * dt
			end
		end
	end
}