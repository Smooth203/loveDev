function showAlert(text)
	loadAlert()
	alert.text = text
	alert.show = true
end

function loadAlert()
	alert = {}
	alert.show = false
	alert.text = ''
	alert.count = 10
end

function drawAlert()
	if alert.show then
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 32)
		love.graphics.print(alert.text, 0, 0)
	end
end

function updateAlert(dt)
	if alert.show then
		alert.count = alert.count - 1 * dt
		if alert.count < 0 then
			alert.show = false
		end
	end
end