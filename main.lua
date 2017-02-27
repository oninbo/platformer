--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 17:50
-- To change this template use File | Settings | File Templates.
--

function love.load()
end

function love.draw()
    for x=0, map.width-1 do
        for y=0, map.height-1 do
            local i = map.get(x,y)
            if i ~= 0 then
                tiles.draw(i, x, y)
            end
        end
    end
end