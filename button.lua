local Button = {}
Button.__index = Button

local buttons = {}
function Button.new(settings)
	local instance = setmetatable({}, Button)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.width  = settings.width or 200
	instance.height = settings.height or 75
	instance.text   = settings.text
	instance.hover  = false
	instance.state  = settings.state
	instance.fn     = settings.fn or function () print(instance.text) end

	if not buttons[instance.state] then
		buttons[instance.state] = {}
	end

	table.insert(buttons[instance.state], instance)

	return instance
end

function Button:isMouseOnButton(mx, my)
	return (self.x <= mx and self.x + self.width >= mx and self.y <= my and self.y + self.height >= my)
end

function Button:mousepressed(mx,my,mouseButton)
	if mouseButton ~= 1 then return end
	for _, button in ipairs(buttons[State.getScene()]) do
		local hovered = button:isMouseOnButton(mx, my)
		if hovered then
			button.fn()
		end
	end
end

function Button:draw()
	for _, button in ipairs(buttons[State.getScene()]) do
		if button.hover then
			love.graphics.setColor(1,0,0)
		else
			love.graphics.setColor(1,1,1)
		end
		love.graphics.rectangle("line", button.x, button.y, button.width, button.height)
		love.graphics.print(button.text, button.x, button.y)
	end
end

function Button:update(dt)
	local mx, my = love.mouse.getPosition()
	for _, button in ipairs(buttons[State.getScene()]) do
		if button:isMouseOnButton(mx, my) then
			button.hover = true
		else
			button.hover = false
		end
	end
end

return Button