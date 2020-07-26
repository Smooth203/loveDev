local textureFile = require 'textures'

World = {}
local world
local worldX, worldY 
local worldW, worldH -- width and height in tiles

local tileDisplayW, tileDisplayH -- number of tiles to show

local zoomX, zoomY

local tilesetImg
local tileSize
local tileQuads = {}

function World:load()
	-- World Setup
	worldW = 60
	worldH = 40

	world = {}
	for x = 1, worldW do
		world[x] = {}
		for y = 1, worldH do
			r = math.random(0, 100)
			if r == 0 then
				world[x][y] = {
					ground = 3,
					entity = 0
				}
			elseif r == 1 then
				world[x][y] = {
					ground = 1,
					entity = 4
				}
			elseif r == 5 or r == 6 then
				world[x][y] = {
					ground = 1,
					entity = 0
				}
			else
				world[x][y] = {
					ground = 2,
					entity = 0
				}
			end
		end
	end

	-- World View Setup (like a cam?)
	worldX = 1
	worldY = 1
	tileDisplayW = 28
	tileDisplayH = 22

	zoomX = 1
	zoomY = 1

	-- Tileset Setup
	tilesetImg = love.graphics.newImage('assets/tileset.png')
	tilesetImg:setFilter('nearest', 'linear')
	tileSize = 32

	--TEXTURES

	for _, texture in pairs(textures) do
		local t = texture
		if t.size == '3x3' then
			local count = 0
			for i = 1, 3 do
				for j = 1, 3 do
					count = count + 1
					id = t.value .. "." .. tostring(count)
					tileQuads[id] = love.graphics.newQuad((i-1)*tileSize, t.subTextures[i][j]*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
				end
			end
		else
			tileQuads[t.value] = love.graphics.newQuad(t.x*tileSize, t.y*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
		end
	end

	groundBatch = love.graphics.newSpriteBatch(tilesetImg, tileDisplayW*tileDisplayH)
	entityBatch = love.graphics.newSpriteBatch(tilesetImg, tileDisplayW*tileDisplayH)

	World:updateTilesetBatch('ground')
	World:updateTilesetBatch('entity')

	--love.graphics.setFont(12)
end

function World:updateTilesetBatch(batch)
	if batch == 'ground' then
		groundBatch:clear()
		for x = 0, tileDisplayW-1 do
			for y = 0, tileDisplayH-1 do
				groundBatch:add(tileQuads[world[x+math.floor(worldX)][y+math.floor(worldY)].ground], x*tileSize, y*tileSize)

				--print(x+math.floor(worldX).. ", " ..y+math.floor(worldY))
				if col(love.graphics.getWidth()/2-tileSize/2, love.graphics.getHeight()/2-tileSize/2, tileSize, tileSize, math.floor(worldX)+14, math.floor(worldY)+11, tileSize, tileSize) then
					world[math.floor(worldX)+14][math.floor(worldY)+11].ground = 0
				end
			end
		end
		groundBatch:flush()
	elseif batch == 'entity' then
		entityBatch:clear()
		for x = 0, tileDisplayW-1 do
			for y = 0, tileDisplayH-1 do

				local ent = world[x+math.floor(worldX)][y+math.floor(worldY)].entity
				--
				if ent == 4 then
					local count = 0
					for i = 1, 3 do
						for j = 1, 3 do
							count = count + 1
							id = tostring(4) .. "." .. tostring(count)
							entityBatch:add(tileQuads[id], ((i-1)*tileSize)+x*tileSize, ((j-1)*tileSize)+y*tileSize)
						end
					end
				else
					entityBatch:add(tileQuads[ent], x*tileSize, y*tileSize)
				end
			end
		end
		entityBatch:flush()
	end
end

function World:draw()
	love.graphics.draw(groundBatch, math.floor(-zoomX*(worldX%1)*tileSize)-tileSize*2, math.floor(-zoomY*(worldY%1)*tileSize)-tileSize*2, 0, zoomX, zoomY)
	love.graphics.draw(entityBatch, math.floor(-zoomX*(worldX%1)*tileSize)-tileSize*2, math.floor(-zoomY*(worldY%1)*tileSize)-tileSize*2, 0, zoomX, zoomY)
	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
	love.graphics.rectangle('line', love.graphics.getWidth()/2-tileSize/2, love.graphics.getHeight()/2-tileSize/2, tileSize, tileSize)
end

function World:update(dt)
	if love.keyboard.isDown('w') then
		World:move(0, -0.1 * tileSize * dt)
	end
	if love.keyboard.isDown('s') then
		World:move(0, 0.1 * tileSize * dt)
	end
	if love.keyboard.isDown('a') then
		World:move(-0.1 * tileSize * dt, 0)
	end
	if love.keyboard.isDown('d') then
		World:move(0.1 * tileSize * dt, 0)
	end
	print(worldX .. ", " .. worldY)
end

function World:move(dx, dy)
	oldX = worldX
	oldY = worldY
	worldX = math.max(math.min(worldX + dx, worldW - tileDisplayW), 1)
	worldY = math.max(math.min(worldY + dy, worldH - tileDisplayH), 1)
	--only update if we move
	if math.floor(worldX) ~= math.floor(oldX) or math.floor(worldY) ~= math.floor(oldY) then
		World:updateTilesetBatch('ground')
		World:updateTilesetBatch('entity')
	end
end