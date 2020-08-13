function save()

	local entities = Entities:get()
	
	local file = io.open('save.txt', 'w')

	local saveString = ""

	for i, e in ipairs(entities) do
		if e.save then
			local save = e:save()
			for j,v in pairs(save) do
				if type(v) ~= 'function' and type(v) ~= 'userdata' then
					file:write(j..","..tostring(v)..";")
				end
			end
		end
	end

	io.close(file)

	--load
	local file = io.open('save.txt', 'r')
	for a in file:read():gmatch('([^,]*);') do
		print(a)
	end

	io.close(file)
end