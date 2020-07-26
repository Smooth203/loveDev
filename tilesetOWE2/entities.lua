entities = {
	load = function()

		entities.types = {}
		require 'scripts/player'

		entities.newEntity('players', 'player', love.graphics.getWidth()/2, love.graphics.getHeight()/2, 20, 20)
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
	newEntity = function(Type, Name, posX, posY, sizeW, sizeH, Img)
		if Name == nil then
			Name = 'Entity'
		end
		if posX == nil then
			posX = 0
		end
		if posY == nil then
			posY = 0
		end
		if sizeW == nil then
			sizeW = 10
		end
		if sizeH == nil then
			sizeH = 10
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