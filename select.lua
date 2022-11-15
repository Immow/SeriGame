local Select = {}

local highlightedTile = {}
highlightedTile.position = {x = 1, y = 1}
highlightedTile.x = (highlightedTile.position.x - 1) * TILE_WIDTH + BOARD_OFFSET_X
highlightedTile.y = (highlightedTile.position.y - 1) * TILE_HEIGHT + BOARD_OFFSET_Y
highlightedTile.width = TILE_WIDTH
highlightedTile.height = TILE_HEIGHT

local selectedTile = {}
selectedTile.position = {x = nil, y = nil}
selectedTile.x = nil
selectedTile.y = nil
selectedTile.width = TILE_WIDTH
selectedTile.height = TILE_HEIGHT
selectedTile.active = false

local function moveSelect(direction)
	if direction == "right" and highlightedTile.position.x < BOARD_TILE_X_AMOUNT then
		highlightedTile.position.x = highlightedTile.position.x + 1
	elseif direction == "left" and highlightedTile.position.x > 1 then
		highlightedTile.position.x = highlightedTile.position.x - 1
	elseif direction == "up" and highlightedTile.position.y > 1 then
		highlightedTile.position.y = highlightedTile.position.y - 1
	elseif direction == "down" and highlightedTile.position.y < BOARD_TILE_Y_AMOUNT then
		highlightedTile.position.y = highlightedTile.position.y + 1
	end

	highlightedTile.x = (highlightedTile.position.x - 1) * TILE_WIDTH + BOARD_OFFSET_X
	highlightedTile.y = (highlightedTile.position.y - 1) * TILE_HEIGHT + BOARD_OFFSET_Y
end

function Select.unselectTile()
	selectedTile.active = false
end

function Select.selectionStatus()
	return selectedTile.active
end

function Select:keypressed(key,scancode,isrepeat)
	if key == "d" then
		moveSelect("right")
	elseif key == "a" then
		moveSelect("left")
	elseif key == "w" then
		moveSelect("up")
	elseif key == "s" then
		moveSelect("down")
	end

	if key == "return" then
		if not selectedTile.active then
			selectedTile.position.x, selectedTile.position.y = highlightedTile.position.x, highlightedTile.position.y
			selectedTile.x = (selectedTile.position.x - 1) * TILE_WIDTH + BOARD_OFFSET_X
			selectedTile.y = (selectedTile.position.y - 1) * TILE_HEIGHT + BOARD_OFFSET_Y
			selectedTile.active = true
		else
			selectedTile.active = false
		end
	end
end

function Select.getSelectedTilePosition()
	return selectedTile.position
end

function Select.getHighligtedTilePosition()
	return highlightedTile.position
end

function Select:drawSelection()
	love.graphics.setColor(1,1,1,1)
	love.graphics.rectangle("line", highlightedTile.x, highlightedTile.y, highlightedTile.width, highlightedTile.height)
	love.graphics.setColor(1,1,1,0.5)
	love.graphics.rectangle("fill", highlightedTile.x, highlightedTile.y, highlightedTile.width, highlightedTile.height)
	love.graphics.setColor(1,1,1,1)
end

function Select:drawSelectTileHiglight()
	if selectedTile.active then
		love.graphics.setLineWidth(2)
		love.graphics.rectangle("line", selectedTile.x, selectedTile.y, selectedTile.width, selectedTile.height)
		love.graphics.setColor(1,1,1,1)
	end
	love.graphics.setLineWidth(1)
end

function Select:update(dt)
	
end

function Select:draw()
	self:drawSelection()
	self:drawSelectTileHiglight()
end

return Select