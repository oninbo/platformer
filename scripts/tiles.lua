--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 27.02.2017
-- Time: 13:52
-- To change this template use File | Settings | File Templates.
--

tiles = {}

local tilesheet = love.graphics.newImage("images/bricks.png")
tilesheet:setFilter("nearest","nearest")
local tileSize = 16
local scale = 2
tiles.tileSize = tileSize*scale

local sheetW = tilesheet:getWidth()/tileSize
local sheetH = tilesheet:getHeight()/tileSize

for i=0, sheetW-1 do
    for j=0, sheetH-1 do
        tiles[(j)*sheetH+i+1] = love.graphics.newQuad(i*tileSize, j*tileSize, tileSize, tileSize, tilesheet:getDimensions())
    end
end

function tiles.draw(index, x, y)
    if tiles[index] ~= nil then
        love.graphics.draw(tilesheet, tiles[index], x, y, 0, scale)
    end
end

tiles.IndexByName = {
    ["grey bricks"] = 1,
    ["dirt"] = 2,
    ["dirt with grass"] = 3,
    ["grey block"] = 4,
    ["yellow block"] = 6,
    ["blue sky"] = 10,
    ["red bricks"] = 21
}

return tiles