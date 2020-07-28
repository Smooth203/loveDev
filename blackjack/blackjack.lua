bj = {}

local deck = {}
local decksUsed = 1

local dealer
local pointsD
local player
local pointsP

local results

function bj:play()
	gamestate = 'playing'

	deck = Cards:newDeck(decksUsed)

	dealer = {}
	player = {}

	results = {}

	bj:shuffle()
	bj:deal()
end

function bj:deal()
	for i = 1, 2 do
		-- Dealer
		local card = table.remove(deck, 1)
		table.insert(dealer, card)
		-- Player
		local card = table.remove(deck, 1)
		table.insert(player, card)
	end
	bj:check()
end

function bj:check(onStand)
	pointsD = 0
	pointsP = 0
	for i, card in ipairs(dealer) do
		pointsD = pointsD + card.Weight
	end
	for i, card in ipairs(player) do
		pointsP = pointsP + card.Weight
	end

	print(pointsD, pointsP)

	if onStand then
		--true
		if pointsD < 17 then
			bj:hit('dealer')
		else
			if pointsD > 21 then
				bj:finish('win')
			elseif pointsD > pointsP then
				bj:finish('lose')
			elseif pointsD == pointsP then
				bj:finish('push')
			else
				bj:finish('win')
			end
		end
	else
		--false
		if pointsD == 21 then
			bj:finish('lose')
		elseif pointsD > 21 then
			bj:finish('win')
		elseif pointsP > 21 then
			bj:finish('lose')
		elseif pointsP == 21 then
			bj:finish('win')
		end
	end
end

function bj:hit(hand)
	local card = table.remove(deck, 1)
	print("Hit: " .. hand .. " - " .. card.Value)
	if hand == 'player' then
		table.insert(player, card)
		bj:check()
	elseif hand == 'dealer' then
		table.insert(dealer, card)
		bj:check(true)
	end
end

function bj:stand()
	print("Stand")
	bj:check(true)
end

function bj:finish(result)
	results.result = result
	results.player = pointsP
	results.dealer = pointsD
	gamestate = 'end'
end

function bj:gameOver()
	love.graphics.setFont(Tfont)
	love.graphics.print(results.result, 10, 10)
	love.graphics.setFont(font)
	love.graphics.print("Player: "..results.player, 10, 100)
	love.graphics.print("Dealer: "..results.dealer, 10, 150)
end

function bj:keypressed(key)
	if key == 'h' then
		bj:hit('player')
	elseif key == 's' then
		bj:stand()
	end
end

function bj:shuffle()
	math.randomseed(os.time())
	for i = 1, 1000 do
		local cardPos1 = math.floor(math.random()*#deck)
		local cardPos2 = math.floor(math.random()*#deck)
		
		local tmp = deck[cardPos1]
		deck[cardPos1] = deck[cardPos2]
		deck[cardPos2] = tmp
	end
end

function bj:draw()
	for i, card in ipairs(player) do
		x, y = ((i-1)*110)+(sw/2)-((55)*#player), sh-160
		love.graphics.rectangle('fill', x, y, 100, 150)
		love.graphics.setColor(0,0,0,1)
		love.graphics.print(card.Value, x+5, y)
		love.graphics.setColor(1,1,1,1)
	end
	for i, card in ipairs(dealer) do
		x, y = ((i-1)*110)+(sw/2)-((55*#dealer)), 10
		love.graphics.rectangle('fill', x, y, 100, 150)
		if #dealer <= 2 then
			if i == 1 then
				love.graphics.print("Dealer: "..(card.Value), 10, 10)
				love.graphics.setColor(0,0,0,1)
				love.graphics.print(card.Value, x+5, y)
			end
		else
			love.graphics.setColor(0,0,0,1)
			love.graphics.print(card.Value, x+5, y)
			love.graphics.print("Dealer: "..pointsD, 10, 10)
		end
		love.graphics.setColor(1,1,1,1)
	end
	love.graphics.setFont(font)
	love.graphics.print("Player: "..pointsP, 10, sh - 45)
end