--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 17:51
-- To change this template use File | Settings | File Templates.
--

map = {}

local sizeX = 40;
local sizeY = 30;

function map.getSizeX() return sizeX end
function map.getSizeY() return sizeY end

local matrix = {}

function map.initialise(sizex, sizey)
    if sizex then sizeX = sizex end
    if sizey then sizeY = sizey end
    for i=1, sizeX do
        table.insert(matrix, {})
        for j=1, sizeY do
            matrix[i][j] = 0
        end
    end
end

return map