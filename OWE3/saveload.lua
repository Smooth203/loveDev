function save()

	local saveDataRaw = {
		Entities:get()
	}


	local saveData = TSerial.pack(saveDataRaw, 0, true)

	local file = io.open('save.txt', 'w')
	file:write(saveData)
	io.close(file)

end

function load()
	local file = io.open('save.txt', 'r')
	local rawData = TSerial.unpack(file:read("*all"), true)
	io.close(file)

	Entities:load(rawData[1])
end