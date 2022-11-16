local Tile = require("tile")
local select = require("select")

local GameBoard = {}
GameBoard.tiles = {}

local function generateTiles(rowX, rowY)
	for y = 1, rowY do
		GameBoard.tiles[y] = {}
		for x = 1, rowX do
			local xPos = BOARD_OFFSET_X + (x - 1) * TILE_WIDTH
			local yPos = BOARD_OFFSET_Y + (y - 1) * TILE_HEIGHT

			GameBoard.tiles[y][x] = Tile.new({
						x = xPos,
						y = yPos,
						width = TILE_WIDTH,
						height = TILE_HEIGHT,
						position = {x = x, y = y}
					})
		end
	end
end

local function copyTable(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

local function swapTiles(a, b)
	local tileA = copyTable(a)
	local tileB = copyTable(b)

	GameBoard.tiles[tileA.position.y][tileA.position.x].quad = tileB.quad
	GameBoard.tiles[tileB.position.y][tileB.position.x].quad = tileA.quad
	GameBoard.tiles[tileA.position.y][tileA.position.x].quadPosition = tileB.quadPosition
	GameBoard.tiles[tileB.position.y][tileB.position.x].quadPosition = tileA.quadPosition
end

local function drawBoard()
	for _, rows in ipairs(GameBoard.tiles) do
		for _, tile in ipairs(rows) do
			tile:draw()
		end
	end
end

local function drawSelect()
	select:draw()
end

local function compareQuadPosition(count, currentTileX, currentTileY, prevTileX, prevTileY)
	if currentTileX == prevTileX and currentTileY == prevTileY then
		count = count + 1
	else
		count = 1
	end
	return count
end

local function checkLine_horizontal()
	for y = 1, BOARD_TILE_Y_AMOUNT do
		local count = 1
		local prevTileX
		local prevTileY
		for x = 1, BOARD_TILE_X_AMOUNT do
			local currentTileX = GameBoard.tiles[y][x].quadPosition.x
			local currentTileY =  GameBoard.tiles[y][x].quadPosition.y
			
			count = compareQuadPosition(count, currentTileX, currentTileY, prevTileX, prevTileY)
			
			if count >= 3 then
				for i = 1, count, 1 do
					GameBoard.tiles[y][x - (i - 1)].state = "marked"
				end
			end
			
			prevTileX = currentTileX
			prevTileY = currentTileY
		end
	end
end

local function checkLine_vertical()
	for x = 1, BOARD_TILE_X_AMOUNT do
		local count = 1
		local prevTileX
		local prevTileY
		for y = 1, BOARD_TILE_Y_AMOUNT do
			local currentTileX = GameBoard.tiles[y][x].quadPosition.x
			local currentTileY =  GameBoard.tiles[y][x].quadPosition.y
			
			count = compareQuadPosition(count, currentTileX, currentTileY, prevTileX, prevTileY)
			
			if count >= 3 then
				for i = 1, count, 1 do
					GameBoard.tiles[y - (i - 1)][x].state = "marked"
				end
			end
			
			prevTileX = currentTileX
			prevTileY = currentTileY
		end
	end
end

function GameBoard:load()
	generateTiles(BOARD_TILE_X_AMOUNT, BOARD_TILE_Y_AMOUNT)
end

function GameBoard:keypressed(key,scancode,isrepeat)
	if key == "return" then
		if select.selectionStatus() then
			swapTiles(
				self.tiles[select.getSelectedTilePosition().y][select.getSelectedTilePosition().x],
				self.tiles[select.getHighligtedTilePosition().y][select.getHighligtedTilePosition().x]
			)
		end
	end
	select:keypressed(key,scancode,isrepeat)
	if key == "space" then
		checkLine_horizontal()
		checkLine_vertical()
	end
end

function GameBoard:update(dt)
end

function GameBoard:draw()
	drawBoard()
	drawSelect()
end

return GameBoard