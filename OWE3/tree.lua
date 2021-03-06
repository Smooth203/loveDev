local texture = {
	name = 'tree',
	x = 12,
	y = 16,
	w = 3,
	h = 2
}

getUnsaveables = function(t, name)
	if name == 'tree' then

		t.dmgAlert = {
			active = false,
			timer = 0
		}

		t.quad = love.graphics.newQuad(texture.x*World:get('tileSize'), texture.y*World:get('tileSize'), texture.w*World:get('tileSize'), texture.h*World:get('tileSize'), World:get('tileset'):getWidth(), World:get('tileset'):getHeight())

		function t.draw(self)
			love.graphics.draw(World:get('tileset'), t.quad,
				math.floor(World:get('x')+(t.x*World:get('tileSize'))),
				math.floor(World:get('y')+(t.y*World:get('tileSize')))
				)

			if t.dmgAlert.timer > 0 then
				love.graphics.setColor(0,0,0,1)
				love.graphics.rectangle('fill', (0.5*World:get('tileSize'))+math.floor(World:get('x')+(t.x*World:get('tileSize'))), (2*World:get('tileSize'))+math.floor(World:get('y')+(t.y*World:get('tileSize'))), (2*World:get('tileSize')), 10)
				love.graphics.setColor(1,0,0,1)
				love.graphics.rectangle('fill', (0.5*World:get('tileSize'))+math.floor(World:get('x')+(t.x*World:get('tileSize'))), (2*World:get('tileSize'))+math.floor(World:get('y')+(t.y*World:get('tileSize'))), (2*World:get('tileSize'))*(t.health/t.maxHealth), 10)
				love.graphics.setColor(1,1,1,1)
			end
		end
		function t.action(self,x,y,button,equipped)
			if col(x,y,0,0, math.floor(World:get('x')+(t.x*World:get('tileSize'))),math.floor(World:get('y')+(t.y*World:get('tileSize'))),t.w*World:get('tileSize'),t.h*World:get('tileSize')) then

				local dmgMultiplier = 1

				if equipped.item.name then
					dmgMultiplier = equipped.item.equip.dmgMultiplier
				end

				if t.health > 0 then
					t.health = t.health - 1 * dmgMultiplier
					t.dmgAlert.timer = 1
					print('Tree Damaged', t.health)
				end
				if t.health <= 0 and not t.chopped then
					Entities:removeEntity(t.id.."TOP")
					Ui:addItem('wood', 'inv')
					Ui:addItem('stick', 'inv')
					print('Tree Chopped')
					t.chopped = true
				end

			else
				error()
			end
		end
		function t.update(self,dt)
			if t.dmgAlert.timer > 0 then
				t.dmgAlert.timer = t.dmgAlert.timer - dt
			else
				t.dmgAlert.timer = 0
			end
		end
		function t.mousepressed(self,x,y,button)

		end
	elseif name == 'top' then

		t.quad = love.graphics.newQuad(9*World:get('tileSize'), 15*World:get('tileSize'), 3*World:get('tileSize'), 3*World:get('tileSize'), World:get('tileset'):getWidth(), World:get('tileset'):getHeight())

		function t.draw()
			love.graphics.draw(World:get('tileset'), t.quad,
				math.floor(World:get('x')+(t.x*World:get('tileSize'))),
				math.floor(World:get('y')+(t.y*World:get('tileSize')))
				)
		end
	end
end

structures['tree'] = function(id,x,y)
	local tree = {}
	tree.Type = 'structure'
	tree.name = 'tree'
	tree.maxHealth = 100
	tree.health = tree.maxHealth
	tree.chopped = false
	tree.id = tostring(id)
	tree.quad = love.graphics.newQuad(texture.x*World:get('tileSize'), texture.y*World:get('tileSize'), texture.w*World:get('tileSize'), texture.h*World:get('tileSize'), World:get('tileset'):getWidth(), World:get('tileset'):getHeight())
	tree.x = x
	tree.y = y
	tree.w = texture.w
	tree.h = texture.h
	getUnsaveables(tree, 'tree')

	--treetop
	local top = {}
	top.Type = 'structure'
	top.id = tostring(id) .. "TOP"
	top.name = 'top'
	top.quad = love.graphics.newQuad(9*World:get('tileSize'), 15*World:get('tileSize'), 3*World:get('tileSize'), 3*World:get('tileSize'), World:get('tileset'):getWidth(), World:get('tileset'):getHeight())
	top.x = x
	top.y = y - 1
	top.w = 3
	top.h = 2
	getUnsaveables(top, 'top')


	return tree, top
end
