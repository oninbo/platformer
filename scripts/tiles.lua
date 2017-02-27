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
local sheetW = tilesheet:getWidth()/tileSize
local sheetH = tilesheet:getHeight()/tileSize
print(sheetW, sheetH)

for i=0, sheetW-1 do
    for j=0, sheetH-1 do
        tiles[(j)*sheetH+i+1] = love.graphics.newQuad(i*tileSize, j*tileSize, tileSize, tileSize, tilesheet:getDimensions())
    end
end

function tiles.draw(index, x, y)
    love.graphics.draw(tilesheet, tiles[index], x*tileSize, y*tileSize)
end

return tiles