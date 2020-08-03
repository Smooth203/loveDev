Player = {}

local player = {}
local world
local sw, sh = love.graphics.getDimensions()

function Player:load()
	world = World:get()
	player.x, player.y = sw/2, sh/2
end

function Player:draw()
	love.graphics.rectangle('fill', player.x, player.y, world.tileSize, world.tileSize)
end

function Player:update(dt)
	if love.keyboard.isDown('w') then
		Player:move(0, -0.1 * world.tileSize * dt, dt)
	end
	if love.keyboard.isDown('s') then
		Player:move(0, 0.1 * world.tileSize * dt, dt)
	end
	if love.keyboard.isDown('a') then
		Player:move(-0.1 * world.tileSize * dt, 0, dt)
	end
	if love.keyboard.isDown('d') then
		Player:move(0.1 * world.tileSize * dt, 0, dt)
	end
end

function Player:move(dx, dy, dt)
	world = World:get()
	--print(math.max(math.min(world.worldX + dx, world.worldW - world.tileDisplayW), 1),math.max(math.min(world.worldY + dy, world.worldH - world.tileDisplayH), 1))

	--print(player.x, player.y, "|", world.worldX, world.worldY)
	--print(math.max(math.min(world.worldX + math.abs(dx), world.worldW - world.tileDisplayW)-math.abs(dx), 1), world.worldX)
	--print("worldXthing="..tostring(math.ceil(math.max(math.min(world.worldX + dx, world.worldW - world.tileDisplayW), 1))), "player.x="..tostring(player.x))
	--print("worldYthing="..tostring(math.ceil(math.max(math.min(world.worldY + dy, world.worldH - world.tileDisplayH), 1))), "player.y="..tostring(player.y))

	tx, ty = math.ceil(math.max(math.min(world.worldX + dx, world.worldW - world.tileDisplayW), 1)), math.ceil(math.max(math.min(world.worldY + dy, world.worldH - world.tileDisplayH), 1))

	if (tx > 1 and tx < 32) and (player.x == sw/2) then
		if player.x > sw/2 then
			player.x = sw/2
		end
		World:move(dx, 0, dt)
	else
		player.x = player.x + dx/dt
	end
	if (ty > 1 and ty < 18) and (player.y == sh/2) then
		if player.y > sh/2 then
			player.y = sh/2
		end
		World:move(0, dy, dt)
	else
		player.y = player.y + dy/dt
	end

	print('tiles')
	for i, tile in pairs(grounds) do
		local x, y = World:getTile('ground', tile.id)
		cx, cy = x*world.tileSize, y*world.tileSize
		if col(player.x, player.y, world.tileSize, world.tileSize,  cx, cy, world.tileSize, world.tileSize) then
			print(tile.id)
			tile.prevQuad = tile.quad
			World:setTile('ground', tile.id, 0)
			tile.entered = true
		end
	end

	-- if (math.max(math.min(world.worldX + math.abs(dx), world.worldW - world.tileDisplayW), 1)-math.abs(dx) ~= 1 and world.worldX ~= 32) and player.x >= 400 then
	-- 	World:move(dx, 0, dt)
	-- else
	-- 	player.x = player.x + dx/dt
	-- end
	-- if (math.max(math.min(world.worldY + math.abs(dy), world.worldH - world.tileDisplayH), 1)-math.abs(dy) ~= 1 and world.worldY ~= 32) and player.y >= 300 then
	-- 	World:move(0, dy, dt)
	-- else
	-- 	player.y = player.y + dy/dt
	-- end
end