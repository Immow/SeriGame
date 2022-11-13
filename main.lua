love.graphics.setDefaultFilter('nearest', 'nearest')

require("settings")
State = require("state")

function love.load()
	State.addScene("mainmenu")
	State.addScene("gameboard")
	State.setScene("gameboard")
end

function love.mousepressed(mx, my, mouseButton)
	State:mousepressed(mx, my, mouseButton)
end

function love.keypressed(key,scancode,isrepeat)
	State:keypressed(key,scancode,isrepeat)
end

function love.draw()
	State:draw()
end

function love.update(dt)
	State:update(dt)
end