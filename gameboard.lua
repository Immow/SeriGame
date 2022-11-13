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

	b.x, b.y, b.position = tileA.x, tileA.y, tileA.position
	a.x, a.y, a.position = tileB.x, tileB.y, tileB.position
	-- print("a: ".."x:"..a.position.x, "y: "..a.position.y)
	-- print("b: ".."x:".. b.position.x, "y: "..b.position.y)

	GameBoard.tiles[a.position.y][a.position.x] = b
	GameBoard.tiles[b.position.y][b.position.x] = a
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

-- FUNCTION TO PRINT TABLES
function tprint (tbl, indent)
	if not indent then indent = 0 end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2 
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if (type(k) == "number") then
			toprint = toprint .. "[" .. k .. "] = "
		elseif (type(k) == "string") then
			toprint = toprint  .. k ..  "= "   
		end
		if (type(v) == "number") then
			toprint = toprint .. v .. ",\r\n"
		elseif (type(v) == "string") then
			toprint = toprint .. "\"" .. v .. "\",\r\n"
		elseif (type(v) == "table") then
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
		end
	end
	toprint = toprint .. string.rep(" ", indent-2) .. "}"
	return toprint
end

function GameBoard:keypressed(key,scancode,isrepeat)
	if key == "return" then
		if select.selectionStatus() then -- and select.getHighligtedTilePosition().x ~= select.getSelectedTilePosition().x and select.getHighligtedTilePosition().y ~= select.getSelectedTilePosition().y
			swapTiles(
				self.tiles[select.getSelectedTilePosition().y][select.getSelectedTilePosition().x],
				self.tiles[select.getHighligtedTilePosition().y][select.getHighligtedTilePosition().x]
			)
		end
	end
	select:keypressed(key,scancode,isrepeat)

	-- if key == "space" then
	-- 	print(tprint(GameBoard.tiles))
	-- end
end

function GameBoard:update(dt)
end

function GameBoard:draw()
	drawBoard()
	drawSelect()
end

return GameBoard