--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 17:51
-- To change this template use File | Settings | File Templates.
--

map = {}

local matrix = {
    {0,0,0,0},
    {0,0,0,0},
    {0,0,1,0},
    {1,1,1,1}
}

function map.goThrough(act)
    for i=1, #matrix do
        for j=1, #matrix[i] do
            act(matrix[i][j], j-1, i-1)
        end
    end
end

--[[function map.initialise(sizex, sizey)
    if sizex then sizeX = sizex end
    if sizey then sizeY = sizey end
    for i=1, sizeX do
        table.insert(matrix, {})
        for j=1, sizeY do
            matrix[i][j] = 0
        end
    end
end]]--

return map