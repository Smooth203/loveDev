items = {
	-- example = {
	-- 	name = 'Example',
	-- 	img = love.graphics.newImage('assets/example.png'),
	-- 	equip = {
	-- 		dmgMultiplier = 1,
	-- 		attackMultiplier = 1
	-- 	}
	-- },
	flower = {
		name = 'Flower',
		img = love.graphics.newImage('assets/flower.png'),
		equip = {
			dmgMultiplier = 25,
			attackMultiplier = 1
		}
	},
	wood = {
		name = 'Wood',
		img = love.graphics.newImage('assets/wood.png')
	}
}

function newItem(item, x, y)
	local item = items[item]
	local tile = World:getTile(math.floor(((x)-World:get('x'))/World:get('tileSize')),math.floor(((y)-World:get('y'))/World:get('tileSize')))
	item.showInfo = false

	function item.draw()
		love.graphics.draw(item.img, item.x, item.y, 0, 0.25, 0.25)
		if item.showInfo then
			love.graphics.rectangle('fill', item.x-20, item.y-30, 80, 25)
			love.graphics.setColor(0,0,0,1)
			love.graphics.print("Pick Up: 'E'", item.x-12.5, item.y-30)
			love.graphics.setColor(1,1,1,1)
		end
		--love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
	end

	function item.update(dt)
		item.x, item.y = math.floor((World:get('x')+(tile.x*World:get('tileSize')))), math.floor(World:get('y')+(tile.y*World:get('tileSize')))
	end

	function item.keypressed(key)
		if key == 'e' then
			print('pick')
			Ui:addItem(string.lower(item.name), 'inv')
		end
	end

	function item.collision(with)
		if col(item.x-World:get('tileSize'),item.y-World:get('tileSize'),3*World:get('tileSize'),3*World:get('tileSize'), with.x,with.y,with.w,with.h) then
			item.showInfo = true
		else
			item.showInfo = false
		end
	end

	return item
end