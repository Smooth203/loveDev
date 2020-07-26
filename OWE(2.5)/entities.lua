--Entities include anything that is not ground. eg(trees, player, buildings)

Entities = {}
local ent
local tilesetImg
local tileSize
local tileQuads = {}
local tileSprite
local tileDisplayW, tileDisplayH -- number of tiles to show

function Entities:load()
	print(world)
	tilesetImg = love.graphics.newImage('assets/tileset.png')
	tilesetImg:setFilter('nearest', 'linear')
	tileSize = 32
	tileDisplayW = 26
	tileDisplayH = 20

	--TEXTURES

	--Tree (3x3 -> Right To Left, Top To Bottom)
	tileQuads[0] = love.graphics.newQuad(0*tileSize, 15*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
	tileQuads[1] = love.graphics.newQuad(1*tileSize, 15*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
	tileQuads[2] = love.graphics.newQuad(2*tileSize, 15*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
	tileQuads[3] = love.graphics.newQuad(0*tileSize, 16*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
	tileQuads[4] = love.graphics.newQuad(1*tileSize, 16*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
	tileQuads[5] = love.graphics.newQuad(2*tileSize, 16*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
	tileQuads[6] = love.graphics.newQuad(0*tileSize, 17*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
	tileQuads[7] = love.graphics.newQuad(1*tileSize, 17*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())
	tileQuads[8] = love.graphics.newQuad(2*tileSize, 17*tileSize, tileSize, tileSize, tilesetImg:getWidth(), tilesetImg:getHeight())

	tilesetBatch = love.graphics.newSpriteBatch(tilesetImg, tileDisplayW*tileDisplayH)

	Entities:updateTilesetBatch()
end

function Entities:updateTilesetBatch()
	tilesetBatch:clear()
	for x = 0, tileDisplayW-1 do
		for y = 0, tileDisplayH-1 do
			--tilesetBatch:add(tileQuads[world[x+math.floor(worldX)][y+math.floor(worldY)]], x*tileSize, y*tileSize)
		end
	end
	tilesetBatch:flush()
end

function Entities:draw()

end