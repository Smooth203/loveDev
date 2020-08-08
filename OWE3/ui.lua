local Items = require 'items'

Ui = {
	get = function(self, p)
		if p == 'mouse' then
			return self.mouse
		end
	end,

	load = function(self)
		self.mouse = {
			x = love.mouse.getX(),
			y = love.mouse.getY(),
			tileX = math.floor(((love.mouse.getX())-World:get('x'))/World:get('tileSize')),
			tileY = math.floor(((love.mouse.getY())-World:get('y'))/World:get('tileSize')),
			tile = {}
		}
		self.inv = {}
		self.invSlotSize = 80
		for i = 0, 4 do
			local slot = {
				id = i,
				isEmpty = true,
				showOptions = false,
				item = {}
			}
			table.insert(self.inv, slot)
		end
	end,

	draw = function(self)
		love.graphics.setColor(0.8, 0.8, 0.8, 1)
		love.graphics.rectangle('fill', (sw/2)-(self.invSlotSize*(#self.inv/2)), sh-self.invSlotSize, self.invSlotSize*(#self.inv), self.invSlotSize)

		for i, slot in pairs(self.inv) do
			local slotX, slotY = (sw/2)-(self.invSlotSize*(#self.inv/2))+((i-1)*self.invSlotSize), sh-self.invSlotSize
			love.graphics.setColor(0,0,0,1)
			love.graphics.rectangle('line', slotX, slotY, self.invSlotSize, self.invSlotSize)
			if slot.item.img then
				love.graphics.setColor(1,1,1,1)
				love.graphics.draw(slot.item.img, slotX, slotY, 0, (self.invSlotSize/World:get('tileSize')), (self.invSlotSize/World:get('tileSize')))
			end
			if slot.showOptions then
				love.graphics.rectangle('fill', slotX, slotY-self.invSlotSize, self.invSlotSize, self.invSlotSize/2)
				love.graphics.rectangle('fill', slotX, slotY-self.invSlotSize/2, self.invSlotSize, self.invSlotSize/2)
				love.graphics.setColor(0,0,0,1)
				love.graphics.print('Use', slotX, slotY-self.invSlotSize)
				love.graphics.print('Drop', slotX, slotY-self.invSlotSize/2)
			end
		end

		love.graphics.setColor(1,1,1,1)
	end,

	update = function(self, dt)
		Ui:updateMouse()
	end,

	updateMouse = function(self)
		self.mouse.x, self.mouse.y = love.mouse.getPosition()
		self.mouse.tileX, self.mouse.tileY = math.floor(((self.mouse.x)-World:get('x'))/World:get('tileSize')), math.floor(((self.mouse.y)-World:get('y'))/World:get('tileSize'))
		self.mouse.tile = World:getTile(self.mouse.tileX, self.mouse.tileY)
	end,

	mousepressed = function(self, x, y, button)
		if button == 1 then
			--Inv
			for i, slot in ipairs(self.inv) do
				local slotX, slotY = (sw/2)-(self.invSlotSize*(#self.inv/2))+((i-1)*self.invSlotSize), sh-self.invSlotSize
				if col(x,y,0,0, slotX, slotY, self.invSlotSize, self.invSlotSize) then
					if slot.isEmpty == false then
						if slot.showOptions == true then
							slot.showOptions = false
						else
							slot.showOptions = true
						end
					end
				elseif col(x,y,0,0, slotX, slotY-self.invSlotSize, self.invSlotSize, self.invSlotSize/2) and slot.showOptions == true then
				    print('Used')
				elseif col(x,y,0,0, slotX, slotY-self.invSlotSize/2, self.invSlotSize, self.invSlotSize/2) and slot.showOptions == true then
					Ui:dropItem(slot)
				    print('Dropped')
				end
			end
		end
	end,

	addItem = function(self, item, to)
		local item = items[item]
		if to == 'inv' then
			for i, slot in ipairs(self.inv) do
				if slot.isEmpty then
					slot.item = item
					slot.isEmpty = false
					break
				end
			end
		end
	end,

	dropItem = function(self, slot)
		slot.item = {}
		slot.showOptions = false
		slot.isEmpty = true
	end,
}