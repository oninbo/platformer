--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 17:50
-- To change this template use File | Settings | File Templates.
--

function love.load()
    require "scripts.map"
    map.initialise()
    require "scripts.blocks"
    print(blocks.getBlockIDByName("dirt"))
end