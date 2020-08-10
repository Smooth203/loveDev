items = {
	-- example = {
	-- 	name = 'Example',
	-- 	img = love.graphics.newImage('assets/example.png'),
	-- 	equip = {
	-- 		dmgMultiplier = 0,
	-- 		attackMultiplier = 0
	-- 	}
	-- },
	flower = {
		name = 'Flower',
		img = love.graphics.newImage('assets/flower.png'),
		equip = {
			dmgMultiplier = 0,
			attackMultiplier = 0
		}
	},
	wood = {
		name = 'Wood',
		img = love.graphics.newImage('assets/wood.png'),
		equip = {
			dmgMultiplier = 0,
			attackMultiplier = 0
		}
	}
}

function newItem(item, x, y)
	local item = items[item]
	item.x = x
	item.y = y

	function item.draw()
		love.graphics.draw(item.img, math.floor(World:get('x')+(item.x), math.floor(World:get('y')+(item.y))))
		--- THIS THIS THIS THIS THSI
	end

	function item.update(dt)

	end

	return item
end