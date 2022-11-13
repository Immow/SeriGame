local Select = {}

local selectedTile = {}
selectedTile.active = false
local higlightedTile = {x = 1, y = 1}

Select.x = (higlightedTile.x - 1) * TILE_WIDTH + BOARD_OFFSET_X
Select.y = (higlightedTile.y - 1) * TILE_HEIGHT + BOARD_OFFSET_Y
Select.xHighlight = nil
Select.yHighlight = nil
Select.width = TILE_WIDTH
Select.height = TILE_HEIGHT

local function moveSelect(direction)
	if direction == "right" and higlightedTile.x < BOARD_TILE_X_AMOUNT then
		higlightedTile.x = higlightedTile.x + 1
	elseif direction == "left" and higlightedTile.x > 1 then
		higlightedTile.x = higlightedTile.x - 1
	elseif direction == "up" and higlightedTile.y > 1 then
		higlightedTile.y = higlightedTile.y - 1
	elseif direction == "down" and higlightedTile.y < BOARD_TILE_Y_AMOUNT then
		higlightedTile.y = higlightedTile.y + 1
	end
	Select.x = (higlightedTile.x - 1) * TILE_WIDTH + BOARD_OFFSET_X
	Select.y = (higlightedTile.y - 1) * TILE_HEIGHT + BOARD_OFFSET_Y
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
			selectedTile.x, selectedTile.y = higlightedTile.x, higlightedTile.y
			print(selectedTile.x, selectedTile.y)
			Select.xHighlight = (selectedTile.x - 1) * TILE_WIDTH + BOARD_OFFSET_X
			Select.yHighlight = (selectedTile.y - 1) * TILE_HEIGHT + BOARD_OFFSET_Y
			selectedTile.active = true
		else
			selectedTile.active = false
		end
	end
end

function Select.getSelectedTilePosition()
	return selectedTile
end

function Select.getHighligtedTilePosition()
	return higlightedTile
end

function Select:drawSelection()
	love.graphics.setColor(1,1,1,1)
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	love.graphics.setColor(1,1,1,0.5)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(1,1,1,1)
end

function Select:drawSelectTileHiglight()
	if selectedTile.active then
		love.graphics.setLineWidth(2)
		love.graphics.rectangle("line", self.xHighlight, self.yHighlight, self.width, self.height)
		love.graphics.setColor(1,1,1,1)
	end
	love.graphics.setLineWidth(1)
end

function Select:update(dt)
	
end

function Select:draw()
	self:drawSelection()
	self:drawSelectTileHiglight()
	love.graphics.print(tostring(selectedTile.active))
end

return Select