function inv(action, item)
	if item == 'all' and action == 'close' then
		for item, _ in pairs(player.inv) do
			player.inv[item].show = false
		end
	else
		if action == 'open' then
			player.inv[item].show = true
		elseif action == 'close' then
			player.inv[item].show = false
		end
	end
end

function use(slot)

end

function loadPlayer()
	player = {}
	player.img = love.graphics.newImage('assets/player.png')
	player.x = love.graphics.getWidth()/2 - player.img:getWidth()/2
	player.y = love.graphics.getHeight()/2 - player.img:getHeight()/2

	player.health = 100
	player.wellness = 100
	player.hunger = 100
	player.thirst = 100

	player.inv = {}
	player.inv.bag = {
		show = false
	}
end

function drawPlayer()
	love.graphics.draw(player.img, player.x, player.y)
	love.graphics.print("H: "..math.floor(player.hunger).." T: "..math.floor(player.thirst).." Time: "..world.time.full, 0, 0)
end

function updatePlayer(dt)
	if love.keyboard.isDown('tab') then
		for item, _ in pairs(player.inv) do
			if item == 'bag' then
				inv('open', 'bag')
				pause()
			else
				showAlert('You do not have a bag!')
			end
		end
	elseif love.keyboard.isDown('j') then
		for item, _ in pairs(player.inv) do
			if item == 'journal' then
				inv('open', 'journal')
				pause()
			else
				showAlert('You do not have a journal!')
			end
		end
	end

	--vitals
	player.hunger = player.hunger - (0.05) * dt
	player.thirst = player.thirst - (0.01) * dt
end