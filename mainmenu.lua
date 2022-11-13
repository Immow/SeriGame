local MainMenu = {}
local Button = require("button")

Button.new({x = 100, y = 100, text = "Start Game", state = "mainmenu", fn = function () State.setScene("gameboard") end})
Button.new({x = 100, y = 200, text = "Exit", state = "mainmenu", fn = function () love.event.quit() end})

function MainMenu:load()

end

function MainMenu:mousepressed(mx, my, mouseButton)
	Button:mousepressed(mx, my, mouseButton)
end

function MainMenu:draw()
	Button:draw()
end

function MainMenu:update(dt)
	Button:update(dt)
end

return MainMenu