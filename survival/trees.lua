function createTrees(amount, img)
	for i = 0, amount do
		tree = {}
		tree.x = math.random(world.x, world.x+world.w)-32
		tree.y = math.random(world.y, world.y+world.h)-46
		tree.img = img
		table.insert(trees, tree)
	end
end

function loadTrees()
	trees = {}
	tree1 = love.graphics.newImage('assets/tree1.png')
	createTrees(10, tree1)
end
function drawTrees()
	for i in pairs(trees) do
		tree = trees[i]
		love.graphics.draw(tree.img, world.x+tree.x, world.y+tree.y)
		--love.graphics.rectangle('line', (world.x+tree.x)-16, (world.y+tree.y)+46, 96, 69)
	end
end

function updateTrees(dt)
end