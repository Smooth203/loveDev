entities = {
	load = function()

		entities.types = {}
		require 'scripts/player'

		entities.newEntity('players', 'player', love.graphics.getWidth()/2, love.graphics.getHeight()/2, love.graphics.newImage('assets/player.png'))
	end,

	draw = function()
		for i, Type in pairs(entities.types) do
			Type.draw()
		end
	end,

	update = function(dt)
		for i, Type in pairs(entities.types) do
			Type.update(dt)
		end
	end,

	--Custom Functions
	newEntity = function(Type, Name, posX, posY, Img, sizeW, sizeH)
		if Name == nil then
			Name = 'Entity'
		end
		if posX == nil then
			posX = 0
		end
		if posY == nil then
			posY = 0
		end
		if Img then
			sizeW, sizeH = Img:getWidth(), Img:getHeight()
		end

		entity = {
			name = Name,
			x = posX,
			y = posY,
			w = sizeW,
			h = sizeH,
			img = Img
		}
		entities.types[Type].new(entity)
	end
}