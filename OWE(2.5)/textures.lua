textures = {
	{
		name = 'empty',
		value = 0,
		x = 0,
		y = 37
	},
	{
		name = 'grass',
		value = 1,
		x = 5,
		y =17
	},
	{
		name = 'grassWithTuft',
		value = 2,
		x = 5,
		y =18
	},
	{
		name = 'grassWithFlowers',
		value = 3,
		x = 6,
		y = 18
	},
	{
		name = 'tree',
		size = '3x3',
		value = 4,
		x = 0,
		y = 15, -- tree core (top left)
		subTextures = {
			{15, 16, 17},
			{15, 16, 17},
			{15, 16, 17}

			-- {
			-- 	x = 1,
			-- 	y = 15
			-- },
			-- {x,y = 2, 15},
			-- {x,y = 0, 16},
			-- {x,y = 1, 16},
			-- {x,y = 2, 16},
			-- {x,y = 0, 17},
			-- {x,y = 1, 17},
			-- {x,y = 2, 17}
		}
	},
}