io.stdout:setvbuf("no") -- live console for ST3

require 'cards'
require 'blackjack'

gamestate = 'menu'
sw, sh = love.graphics.getDimensions()
Tfont = love.graphics.setNewFont(32)
font = love.graphics.setNewFont(24)

function love.load()
	bj:play()
end

function love.draw()
	if gamestate == 'menu' then
		love.graphics.setFont(Tfont)
		love.graphics.print('Blackjack', 10, 10)
		love.graphics.setFont(font)
		love.graphics.print('Play', 10, 150)
	elseif gamestate == 'playing' then
		bj:draw()
	elseif gamestate == 'end' then
		bj:gameOver()
	end
end

function love.update(dt)
	if gamestate == 'menu' then
		--scroll = scroll + 1 * dt
	end
end

function love.keypressed(key)
	bj:keypressed(key)
end