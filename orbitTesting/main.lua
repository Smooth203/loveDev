io.stdout:setvbuf("no") -- live console for ST3

function love.load()
	world = love.physics.newWorld(0, 0, true)

	--gravity
	G = 1000


	objects = {}

	scale = 0.25

	objects.sun = {}
	-- x/2 because body anchors from centre so 50 in each direction, total 100
	objects.sun.body = love.physics.newBody(world, (1000/2), (1000/2), 'dynamic')
	objects.sun.shape = love.physics.newCircleShape(500)
	-- attach shape to body
	objects.sun.fixture = love.physics.newFixture(objects.sun.body, objects.sun.shape)
	objects.sun.body:setPosition(0, 0)

	objects.planet = {}
	objects.planet.body = love.physics.newBody(world, (10/2), (10/2), 'dynamic')
	objects.planet.shape = love.physics.newCircleShape(5)
	objects.planet.fixture = love.physics.newFixture(objects.planet.body, objects.planet.shape)
	objects.planet.body:setPosition(0, 800)

	objects.planet.body:setLinearVelocity(125, 0)

end

function love.update(dt)
	world:update(dt)

	--gravity
	-- F = Gm1m2 / r^2
	-- r^2 = rSq
	--rSq = scale * (objects.planet.body:getX()-objects.sun.body:getX())^2 + (objects.planet.body:getY()-objects.sun.body:getY())^2
	--force1 = (G * objects.sun.body:getMass() * objects.sun.body:getMass()) / rSq
	---angle = math.atan( (objects.planet.body:getX()-objects.sun.body:getX())^2 / (objects.planet.body:getY()-objects.sun.body:getY())^2 )
	--angle = math.atan( (objects.planet.body:getX()-objects.sun.body:getX())^2 / (objects.planet.body:getY()-objects.sun.body:getY())^2 )
	--objects.planet.body:applyForce(force1*math.cos(angle), force1*math.sin(angle))
	--objects.sun.body:applyForce(force1*math.cos(angle), force1*math.sin(angle))

	dist = scale * math.sqrt((objects.sun.body:getX()-objects.planet.body:getX())^2 + (objects.sun.body:getY()-objects.planet.body:getY())^2)
	angle = math.atan2( objects.sun.body:getY()-objects.planet.body:getY(), objects.sun.body:getX()-objects.planet.body:getX() )
	force = (G * objects.sun.body:getMass() * objects.planet.body:getMass()) / (dist^2)
	objects.planet.body:applyForce(force*math.cos(angle), force*math.sin(angle))

	--objects.planet.body:applyForce(10*math.cos(math.pi/2), 10*math.sin(math.pi/2))


	--print(angle*(180/math.pi), force, dist)
	tv = objects.planet.body:getAngularVelocity() * dist -- vel tangential to motion
	print(tv)


	if love.keyboard.isDown('up') then
		world:translateOrigin(0, -10)
	elseif love.keyboard.isDown('down') then
		world:translateOrigin(0, 10)
	end
	if love.keyboard.isDown('right') then
		world:translateOrigin(10, 0)
	elseif love.keyboard.isDown('left') then
		world:translateOrigin(-10, 0)
	end

	--print(objects.sun.body:getMass())
end

function love.draw()
	love.graphics.setColor(0.953, 0.51, 0.208)
	love.graphics.circle('fill', objects.sun.body:getX()*scale, objects.sun.body:getY()*scale, objects.sun.shape:getRadius()*scale)

	love.graphics.setColor(0.553, 0.81, 0.108)
	love.graphics.circle('fill', objects.planet.body:getX()*scale, objects.planet.body:getY()*scale, objects.planet.shape:getRadius()*scale)
end