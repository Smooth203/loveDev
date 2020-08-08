function newPlayer(name, x, y, control, img)
	
	if control == 'wasd' then
		up = 'w'
		left = 'a'
		down = 's'
		right = 'd'
	elseif control == 'arrow' then
		up = 'up'
		left = 'left'
		down = 'down'
		right = 'right'
	end

	local player = {
		name = name,
		x = x,
		y = y,
		speed = 100,
		control = {
			up = up,
			left = left,
			down = down,
			right = right
		},
		img = img,
		w = img:getWidth(),
		h = img:getHeight(),
		r = 0,
		timer = 100
	}

	function player.draw()
		love.graphics.draw(player.img, player.x, player.y, player.r, 1, 1, player.img:getWidth()/2, player.img:getHeight()/2)
		
		if col(Ui:get('mouse').x,Ui:get('mouse').y,0,0, player.x-100, player.y-100,200,200) then
			love.graphics.rectangle('line', (Ui:get('mouse').tile.x*32)+World:get('x'), (Ui:get('mouse').tile.y*32)+World:get('y'), 32, 32)
		end

		love.graphics.print(math.floor((player.x+player.img:getWidth()/2)-World:get('x'))..", "..math.floor((player.y+player.img:getHeight()/2)-World:get('y')), 10, 50)
		love.graphics.print(math.floor(((player.x+player.img:getWidth()/2)-World:get('x'))/World:get('tileSize'))..", "..math.floor(((player.y+player.img:getHeight()/2)-World:get('y'))/World:get('tileSize')), 10, 70)
	end

	function player.update(dt)
		player.move(dt)

		--playerTile
		--player.tileX, player.tileY = math.floor(((player.x)-World:get('x'))/World:get('tileSize')), math.floor(((player.y)-World:get('y'))/World:get('tileSize'))

		player.camAdjust(dt)

		--World:getTile(math.floor((player.x-World:get('x'))/World:get('tileSize')), math.floor((player.y-World:get('y'))/World:get('tileSize')))
	end

	function player.mousepressed(x, y, button)
		if button == 1 then
			local tile = Ui:get('mouse').tile
			if col(Ui:get('mouse').x,Ui:get('mouse').y,0,0, player.x-100, player.y-100,200,200) then
				if tile.texture == 3 then
					World:setTile(tile.x, tile.y, 1)
					Ui:addItem('flower', 'inv')
				end
			end
		end
	end

	function player.camAdjust(dt)
		if player.stoppedX and player.stoppedY then
			player.timer = player.timer - 10 * dt
			if player.timer < 0 then
				if player.x > sw/2 then
					player.x = player.x - 50 * dt
					World:move(-50 * dt, 0)
				end
				if player.x < sw/2 then
					player.x = player.x + 50 * dt
					World:move(50 * dt, 0)
				end
				if player.y > sh/2 then
					player.y = player.y - 50 * dt
					World:move(0, -50 * dt)
				end
				if player.y < sh/2 then
					player.y = player.y + 50 * dt
					World:move(0, 50 * dt)
				end
				player.timer = 0
			end
		else
			player.timer = 100
		end
	end

	function player.move(dt)
		if player.x+player.img:getWidth() >= sw/3 and player.x <= sw -(sw /3) then
			if love.keyboard.isDown(player.control.left) then
				player.x = player.x - player.speed * dt
				player.r = math.pi
				player.stoppedX = false
			elseif love.keyboard.isDown(player.control.right) then
				player.x = player.x + player.speed * dt
				player.r = 0
				player.stoppedX = false
			else
				player.stoppedX = true
			end
		end
		if player.x+player.img:getWidth() > sw-(sw/3) then
			player.x = sw-(sw/3)-player.img:getHeight()
			World:move(-player.speed * dt, 0)
		elseif player.x < sw/3 then
			player.x = sw/3
			World:move(player.speed * dt, 0)
		end
			
		if player.y+player.img:getHeight() >= sh/3 and player.y <= sh-(sh/3) then
			if love.keyboard.isDown(player.control.up) then
				player.y = player.y - player.speed * dt
				player.r = 3*math.pi/2
				player.stoppedY = false
			elseif love.keyboard.isDown(player.control.down) then
				player.y = player.y + player.speed * dt
				player.r = math.pi/2
				player.stoppedY = false
			else
				player.stoppedY = true
			end
		end
		if player.y+player.img:getHeight() > sh-(sh/3) then
			player.y = sh-(sh/3)-player.img:getHeight()
			World:move(0, -player.speed * dt)
		elseif player.y < sh/3 then
			player.y = sh/3
			World:move(0, player.speed * dt)
		end
	end

	return player
end