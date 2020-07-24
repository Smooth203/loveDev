entities = {
	load = function()

		entities.list = {}

		entities.newEntity('player')

		print(entities.list[1].name)
	end,

	--Custom Functions
	newEntity = function(Name, posX, posY, sizeW, sizeH, Img)
		entity = {
			name = Name,
			x = posX,
			y = posY,
			w = sizeW,
			h = sizeH,
			img = Img
		}
		table.insert(entities.list, entity)
	end
}