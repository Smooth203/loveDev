Player = {}

local player = {}

function Player:load()
	player.x, player.y = World:getPos()
	--print(World:getTile('ground', 308))
	World:setTile('ground', 50)
	--player.x, player.y = player.x+(14*World:getTile('ground')), player.y+(11*World:getTile('ground'))
end

function Player:draw()
	love.graphics.rectangle('fill', player.x, player.y, 10, 10)
end