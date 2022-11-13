local State = {}
local scenes = {}
local currentScene = nil

function State.addScene(scene)
	scenes[scene] = require(scene)
end

function State:update(dt)
	if scenes[currentScene].update then scenes[currentScene]:update(dt) end
end

function State:draw()
	if scenes[currentScene].draw then scenes[currentScene]:draw() end
end

function State:mousepressed(x,y,button,istouch,presses)
	if scenes[currentScene].mousepressed then scenes[currentScene]:mousepressed(x,y,button,istouch,presses) end
end

function State:keypressed(key,scancode,isrepeat)
	if scenes[currentScene].keypressed then scenes[currentScene]:keypressed(key,scancode,isrepeat) end
end

function State.setScene(nextScene)
	currentScene = nextScene

	if scenes[currentScene].load then scenes[currentScene]:load() end
end

function State.getScene()
	if currentScene then
		return currentScene
	else
		error("No scenes found")
	end
end

return State