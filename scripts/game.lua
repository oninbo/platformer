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

    require "scripts.player"
    game.setInitialPlayerCoordinates()
end

function game.drawMap()
    for x=0, map.width-1 do
        for y=0, map.height-1 do
            local i = map.get(x, y)
            local _x = x*tiles.tileSize
            local _y = y*tiles.tileSize
            tiles.draw(i, _x, _y)
            --if i == 0 then tiles.draw(tiles.IndexByName["blue sky"], _x, _y) end
        end
    end
end

function game.setInitialPlayerCoordinates()
    local spawnPoint = map.spawnPoint
    player.setCoordinates(spawnPoint.x*tiles.tileSize-player.size, spawnPoint.y*tiles.tileSize-player.size)
end

function game.drawPlayer()
    player.draw()
end

function game.setPlayerCoordinates(dt)
    if love.keyboard.isDown("left") then player.x = player.x - player.speed*dt
    elseif love.keyboard.isDown("right") then player.x = player.x + player.speed*dt end
end