--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 17:51
-- To change this template use File | Settings | File Templates.
--

map = {
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,2,2,2,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    2,2,0,0,0,0,0,0,0,0,0,2,2,2,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
}

map.width = 16
map.height = 12

local function XYto1D(x, y) return 1+(map.width*y)+x end

function map.get(x, y)
    return map[XYto1D(x, y)]
end

function map.put(value, x, y)
    map[XYto1D(x, y)] = value
end

map.spawnPoint = {x = 8, y = 11}

return map