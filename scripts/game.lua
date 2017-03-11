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
    player.setCoordinates(spawnPoint.x*tiles.tileSize, spawnPoint.y*tiles.tileSize-player.size)
end

function game.drawPlayer()
    player.draw()
end

local function distanseToObstacle(direction)
    local minX = math.floor(player.x / tiles.tileSize)
    local maxX = math.ceil((player.x+player.size) / tiles.tileSize)-1
    local minY = math.floor(player.y / tiles.tileSize)
    local maxY = math.ceil((player.y + player.size) / tiles.tileSize)-1
    if direction == "left" then
        for x = minX, 0, -1 do
            for y = minY, maxY do
                if map.get(x, y) ~= 0 then return math.abs(player.x - (x+1)*tiles.tileSize) end
            end
        end
        return math.abs(player.x)
    elseif direction == "right" then
        for x = maxX, map.width do
            for y = minY, maxY do
                if map.get(x, y) ~= 0 then return math.abs(player.x+player.size - x*tiles.tileSize) end
            end
        end
        return math.abs(player.x+player.size - map.width*tiles.tileSize)
    elseif direction == "up" then
        for y = minY, 0, -1 do
            for x = minX, maxX do
                if map.get(x, y) ~= 0 then return math.abs(player.y - (y+1)*tiles.tileSize) end
            end
        end
        return math.abs(player.y)
    elseif direction == "down" then
        for y = maxY, map.height do
            for x = minX, maxX do
                if map.get(x, y) ~= 0 then return math.abs(player.y+player.size - y*tiles.tileSize) end
            end
        end
        return math.abs(player.y+player.size - map.height*tiles.tileSize)
    end
end

function game.setPlayerCoordinates(dt)
    if love.keyboard.isDown("left") then
        player.x = player.x - math.min(player.speed*dt, distanseToObstacle("left"))
    elseif love.keyboard.isDown("right") then
        player.x = player.x + math.min(player.speed*dt, distanseToObstacle("right"))
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - math.min(player.speed*dt, distanseToObstacle("up"))
    else
        player.y = player.y + math.min(player.speed*dt, distanseToObstacle("down"))
    end
end