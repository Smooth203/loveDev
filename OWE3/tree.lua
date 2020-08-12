local texture = {
	name = 'tree',
	x = 12,
	y = 16,
	w = 3,
	h = 2
}

Structures['tree'] = function(id,x,y)
		local tree = {}
		tree.health = 100
		tree.chopped = false
		tree.id = tostring(id)
		tree.quad = love.graphics.newQuad(texture.x*World:get('tileSize'), texture.y*World:get('tileSize'), texture.w*World:get('tileSize'), texture.h*World:get('tileSize'), World:get('tileset'):getWidth(), World:get('tileset'):getHeight())
		tree.x = x
		tree.y = y
		tree.w = texture.w
		tree.h = texture.h


		function tree.draw()
			love.graphics.draw(World:get('tileset'), tree.quad,
				math.floor(World:get('x')+(tree.x*World:get('tileSize'))),
				math.floor(World:get('y')+(tree.y*World:get('tileSize')))
				)
		end
		function tree.action(x,y,button,equipped)
			if col(x,y,0,0, math.floor(World:get('x')+(tree.x*World:get('tileSize'))),math.floor(World:get('y')+(tree.y*World:get('tileSize'))),tree.w*World:get('tileSize'),tree.h*World:get('tileSize')) then

				local dmgMultiplier = 1

				if equipped.item.name then
					dmgMultiplier = equipped.item.equip.dmgMultiplier
				end

				if tree.health > 0 then
					tree.health = tree.health - 1 * dmgMultiplier
					print('Tree Damaged', tree.health)
				end
				if tree.health <= 0 and not tree.chopped then
					Entities:removeEntity(tree.id.."TOP")
					Ui:addItem('wood', 'inv')
					print('Tree Chopped')
					tree.chopped = true
				end

			else
				error()
			end
		end
		function tree.update(dt)

		end
		function tree.mousepressed(x,y,button)

		end

		--treetop
		local top = {}
		top.id = tostring(id) .. "TOP"
		top.quad = love.graphics.newQuad(9*World:get('tileSize'), 15*World:get('tileSize'), 3*World:get('tileSize'), 3*World:get('tileSize'), World:get('tileset'):getWidth(), World:get('tileset'):getHeight())
		top.x = x
		top.y = y - 1
		top.w = 3
		top.h = 2
		function top.draw()
			love.graphics.draw(World:get('tileset'), top.quad,
				math.floor(World:get('x')+(top.x*World:get('tileSize'))),
				math.floor(World:get('y')+(top.y*World:get('tileSize')))
				)
		end

		return tree, top
end