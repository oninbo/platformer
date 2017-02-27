--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 27.02.2017
-- Time: 14:38
-- To change this template use File | Settings | File Templates.
--

game = {}

function game.start()
    require "scripts.map"
    require "scripts.tiles"

    love.window.setTitle("My Platformer")
    love.window.setMode(tiles.tileSize*map.width, tiles.tileSize*map.height, {resizable=false, vsync=false})
end

function game.drawMap()
    for x=0, map.width-1 do
        for y=0, map.height-1 do
            local i = map.get(x, y)
                tiles.draw(i, x, y)
        end
    end
end