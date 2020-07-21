function loadUI()
	--inv
	slotH, slotV = 0, 0
end

function drawUI()
	if player.inv.bag.show then
		local width = love.graphics.getWidth()
		local height = love.graphics.getHeight()
		local bagX, bagY = width/6, height/6
		local slotX, slotY = (width-width/3)/4, (height-height/3)/2
		
		love.graphics.setColor(0.6, 0.6, 0.6)
		love.graphics.rectangle('fill', bagX, bagY, width-width/3, height-height/3)
		love.graphics.setColor(0.2, 0.2, 0.2)
		for x = 0, 3 do
			for y = 0, 1 do
				love.graphics.rectangle('line', x*slotX+bagX, y*slotY+bagY, slotX, slotY)
			end
		end
		love.graphics.setColor(1,1,1,0.25)
		love.graphics.rectangle('fill', slotH*slotX+bagX, slotV*slotY+bagY, slotX, slotY)
		


		love.graphics.setColor(1,1,1,1)
	end
end

function updateUI(dt)
	if love.keyboard.isDown('escape') and paused then
		inv('close', 'all')
		pause()
	end
	if player.inv.bag.show then
		if slotH < 0 then
			slotH = 3
		elseif slotH > 3 then
			slotH = 0
		end
		if slotV < 0 then
			slotV = 1
		elseif slotV > 1 then
			slotV = 0
		end
	end
end

function keypressedUI(key)
	if player.inv.bag.show then
		if key == 'up' or key == 'w' then
			slotV = slotV - 1
		elseif key == 'down' or key == 's' then
			slotV = slotV + 1
		elseif key == 'left' or key == 'a' then
			slotH = slotH - 1
		elseif key == 'right' or key == 'd' then
			slotH = slotH + 1
		elseif key == 'return' then
			local slot = slotH .. slotV
			use(slot)
		end
	end
end