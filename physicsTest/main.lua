function love.load()
	world = love.physics.newWorld(0, 0, true)

	speed = 0
	r = 0

	objects = {}

	objects.car = {}
	objects.car.body = love.physics.newBody(world, 50, 50, 'dynamic') -- pos(50, 50) 'dynamic' = interactable 
	objects.car.shape = love.physics.newRectangleShape(25, 25)
	objects.car.fixture = love.physics.newFixture(objects.car.body, objects.car.shape, 1)
end

function love.update(dt)
	world:update(dt) --puts world into motion
	vx, vy = objects.car.body:getLinearVelocity()
	cx, cy = objects.car.body:getWorldCenter(objects.car.shape)
	objects.car.body:applyForce(math.cos(r)*speed, math.sin(r)*speed)
	if love.keyboard.isDown('w') then
		speed = 100
	elseif love.keyboard.isDown('s') then
		speed = -100
	else
		speed = 0
	end
	if love.keyboard.isDown('a') then
		r = r - 1 * dt
	elseif love.keyboard.isDown('d') then
		r = r + 1 * dt
	else
		t = 0
	end
end

function love.draw()
	love.graphics.print(vx.." "..vy.." : "..objects.car.body:getAngle(), 0, 0)
	love.graphics.line(cx, cy, cx+100*math.cos(r), cy+100*math.sin(r))
	love.graphics.polygon('fill', objects.car.body:getWorldPoints(objects.car.shape:getPoints()))
end