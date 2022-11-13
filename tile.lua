local Tile = {}
Tile.__index = Tile

local function getQuad()
	local x = love.math.random(0, SPRITE:getWidth() / TILE_WIDTH - 1)
	local y = love.math.random(0, SPRITE:getHeight() / TILE_HEIGHT - 1)

	return love.graphics.newQuad(
		x * TILE_WIDTH,
		y * TILE_HEIGHT,
		TILE_WIDTH,
		TILE_HEIGHT,
		SPRITE:getDimensions()
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

	return instance
end

function Tile:update(dt)
	
end

function Tile:draw()
	love.graphics.draw(SPRITE, self.quad, self.x, self.y)
end

return Tile