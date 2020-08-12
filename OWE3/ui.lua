local Items = require 'items'

Ui = {
	get = function(self, p)
		if p == 'mouse' then
			return self.mouse
		elseif p == 'inv' then
			return self.inv, self.equipped
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
		--Inv & Equipped
		self.inv = {}
		self.invSlotSize = 80
		for i = 1, 5 do
			local slot = {
				location = 'inv',
				id = i,
				isEmpty = true,
				showOptions = false,
				item = {}
			}
			table.insert(self.inv, slot)
		end
		self.equipped = {
			location = 'equipped',
			isEmpty = true,
			showOptions = false,
			item = {}
		}
	end,

	draw = function(self)
		love.graphics.setColor(0.8, 0.8, 0.8, 1)
		love.graphics.rectangle('fill', (sw/2)-(self.invSlotSize*(#self.inv/2)), sh-self.invSlotSize, self.invSlotSize*(#self.inv), self.invSlotSize)

		for i, slot in pairs(self.inv) do
			local slotX, slotY = (sw/2)-(self.invSlotSize*(#self.inv/2))+((i-1)*self.invSlotSize), sh-self.invSlotSize
			love.graphics.setColor(0,0,0,1)
			love.graphics.rectangle('line', slotX, slotY, self.invSlotSize, self.invSlotSize)
			if not pcall(function() if slot.item then else error(i) end end) then
				--print(pcall(function() if slot.item then else error(i) end end))
			end
			if slot.item.img then
				love.graphics.setColor(1,1,1,1)
				love.graphics.draw(slot.item.img, slotX, slotY)
			end
			if slot.showOptions then
				love.graphics.rectangle('fill', slotX, slotY-(self.invSlotSize/2), self.invSlotSize, self.invSlotSize/2)
				love.graphics.rectangle('fill', slotX, slotY-(self.invSlotSize/2)*2, self.invSlotSize, self.invSlotSize/2)
				love.graphics.rectangle('fill', slotX, slotY-(self.invSlotSize/2)*3, self.invSlotSize, self.invSlotSize/2)
				love.graphics.setColor(0,0,0,1)
				love.graphics.print('Drop', slotX, slotY-(self.invSlotSize/2))
				love.graphics.print('Use', slotX, slotY-(self.invSlotSize/2)*2)
				love.graphics.print('Equip', slotX, slotY-(self.invSlotSize/2)*3)
			end
		end

		--equipped
		love.graphics.setColor(0.8, 0.8, 0.8, 1)
		love.graphics.rectangle('fill', sw-self.invSlotSize, sh-self.invSlotSize, self.invSlotSize, self.invSlotSize)
		love.graphics.setColor(0,0,0,1)
		love.graphics.rectangle('line', sw-self.invSlotSize, sh-self.invSlotSize, self.invSlotSize, self.invSlotSize)
		if self.equipped.item.img then
			love.graphics.setColor(1,1,1,1)
			love.graphics.draw(self.equipped.item.img, sw-self.invSlotSize, sh-self.invSlotSize)
		end
		if self.equipped.showOptions then
			love.graphics.rectangle('fill', sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2), self.invSlotSize, self.invSlotSize/2)
			love.graphics.rectangle('fill', sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2)*2, self.invSlotSize, self.invSlotSize/2)
			love.graphics.rectangle('fill', sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2)*3, self.invSlotSize, self.invSlotSize/2)
			love.graphics.setColor(0,0,0,1)
			love.graphics.print('Drop', sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2))
			love.graphics.print('Use', sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2)*2)
			love.graphics.print('Un-Equip', sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2)*3)
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
					--inv
					if slot.isEmpty == false then
						if slot.showOptions == true then
							slot.showOptions = false
						else
							slot.showOptions = true
						end
					end
				elseif col(x,y,0,0, slotX, slotY-(self.invSlotSize/2), self.invSlotSize, self.invSlotSize/2) and slot.showOptions == true then
					Ui:dropItem(slot)
					print('Dropped')
				elseif col(x,y,0,0, slotX, slotY-(self.invSlotSize/2)*2, self.invSlotSize, self.invSlotSize/2) and slot.showOptions == true then
					print('Used')
				elseif col(x,y,0,0, slotX, slotY-(self.invSlotSize/2)*3, self.invSlotSize, self.invSlotSize/2) and slot.showOptions == true then
					if slot.item.equip then
						Ui:swapItem(slot, self.equipped)
						print('Equipped')
					else
						print('Not Equippable')
					end
				end
			end
			--equip
			if col(x,y,0,0, sw-self.invSlotSize, sh-self.invSlotSize, self.invSlotSize, self.invSlotSize) then
				--EquippedOptions
				if self.equipped.showOptions == true then
					self.equipped.showOptions = false
				else
					self.equipped.showOptions = true
				end
			elseif col(x,y,0,0, sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2), self.invSlotSize, self.invSlotSize/2) and self.equipped.showOptions == true then
				Ui:dropItem(self.equipped)
				print('Dropped')
			elseif col(x,y,0,0, sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2)*2, self.invSlotSize, self.invSlotSize/2) and self.equipped.showOptions == true then
				print('Used')
			elseif col(x,y,0,0, sw-self.invSlotSize, sh-self.invSlotSize-(self.invSlotSize/2)*3, self.invSlotSize, self.invSlotSize/2) and self.equipped.showOptions == true then

				--Ui:swapItem(self.equipped, 'inv', string.lower(self.equipped.item.name))
				Ui:unequip()
				print('Un-Equipped')
			end
		end
	end,

	addItem = function(self, item, to, toSlot)
		local item = items[item]
		local complete = false
		if to == 'inv' then
			if toSlot == nil then
				for i, slot in ipairs(self.inv) do
					if slot.isEmpty then
						slot.item = item
						slot.isEmpty = false
						complete = true
						break
					end
				end
			else
				if item then
					self.inv[toSlot].item = item
					self.inv[toSlot].isEmpty = false
				end
			end
		elseif to == 'equipped' then
			self.equipped.item = item
			complete = true
		end
		if complete then
			return true
		end
	end,

	destroyItem = function(self, slot)
		slot.item = {}
		slot.showOptions = false
		slot.isEmpty = true
	end,

	dropItem = function(self, slot)
		Entities:dropItem(string.lower(slot.item.name), Entities:getPlayer().x, Entities:getPlayer().y)
		Ui:destroyItem(slot)
	end,

	swapItem = function(self, from, to, item)
		local tmp = to.item.name
		Ui:addItem(string.lower(from.item.name), to.location)
		Ui:destroyItem(from)
		if tmp ~= nil then
			Ui:addItem(string.lower(tmp), 'inv')
		end
	end,

	unequip = function(self)
		Ui:addItem(string.lower(self.equipped.item.name), 'inv')
		Ui:destroyItem(self.equipped)
	end,
}