local Tile = require("tile")
local select = require("select")

local GameBoard = {}
GameBoard.tiles = {}
local sprite = love.graphics.newImage("match3.png")

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
end

function GameBoard:update(dt)
end

function GameBoard:draw()
	drawBoard()
	drawSelect()
end

return GameBoard