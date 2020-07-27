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
	print("worldX="..tostring(world.worldX), "player.x="..tostring(player.x))

	if (worldX ~= 1) then
		World:move(dx, 0, dt)
	else
		player.x = player.x + dx/dt
	end
	if (player.y >= sh/2) then
		World:move(0, dy, dt)
	else
		player.y = player.y + dy/dt
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