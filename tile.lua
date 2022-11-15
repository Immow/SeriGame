local Tile = {}
Tile.__index = Tile

local sprite = love.graphics.newImage("match3.png")
local quadPosition = {}

local function getQuad()
	quadPosition.x = love.math.random(0, 2)
	quadPosition.y = love.math.random(0, 0)

	return love.graphics.newQuad(
		quadPosition.x * TILE_WIDTH,
		quadPosition.y * TILE_HEIGHT,
		TILE_WIDTH,
		TILE_HEIGHT,
		sprite:getDimensions()
	)
end

function Tile.new(settings)
	local instance = setmetatable({}, Tile)
	instance.x      = settings.x
	instance.y      = settings.y
	instance.width  = settings.width
	instance.height = settings.height
	instance.position = settings.position
	instance.quad = settings.quad or getQuad()
	instance.quadPosition = {x = quadPosition.x, y = quadPosition.y}
	instance.state = "active"
	instance.active = true

	return instance
end

function Tile:update(dt)
	
end

function Tile:draw()
	love.graphics.draw(sprite, self.quad, self.x, self.y)
	-- love.graphics.print(self.position.x.."\n"..self.position.y, self.x, self.y)
	love.graphics.print(self.quadPosition.x.."\n"..self.quadPosition.y, self.x, self.y)
	if self.state == "marked" then
		love.graphics.setColor(0,1,0,1)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
		love.graphics.setColor(1,1,1,1)
	end
end

return Tile