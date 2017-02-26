--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 17:50
-- To change this template use File | Settings | File Templates.
--

function love.load()
    require "scripts.map"
    require "scripts.blocks"
end

function love.draw()
    map.goThrough(
        function(id, x, y)
            blocks[id]:draw(x, y)
        end
    )
end