--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 27.02.2017
-- Time: 14:38
-- To change this template use File | Settings | File Templates.
--

local function minAbs(a, b)
    if math.abs(a) <= math.abs(b) then return a
        else return b end
end

local G = 30

game = {}

function game.start()
    require "scripts.map"
    require "scripts.tiles"

    love.window.setTitle("My Platformer")
    love.window.setMode(tiles.tileSize*map.width, tiles.tileSize*map.height, {resizable=false, vsync=true})

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

function game.setPlayerSpeed(dt)
    if love.keyboard.isDown("left") then
        player.speedX = - player.speed
    elseif love.keyboard.isDown("right") then
        player.speedX = player.speed
    else
        player.speedX = 0
    end
    if distanseToObstacle("up") == 0 or distanseToObstacle("down") == 0 then
        player.speedY = 0
    end
    player.speedY = player.speedY - G*dt
    if love.keyboard.isDown("space") then
        if distanseToObstacle("down") == 0 then
            player.jumping = true
        end
        if player.jumping and player.speedY <= player.jumpSpeed then
            player.speedY = player.speedY + player.jumpSpeed*dt
        end
    else
        player.jumping = false
    end
end
function game.setPlayerCoordinates(dt)
    if player.speedX > 0 then
        player.x = player.x + minAbs(player.speedX*dt, distanseToObstacle("right"))
    else
        player.x = player.x + minAbs(player.speedX*dt, -distanseToObstacle("left"))
    end
    if player.speedY > 0 then
        player.y = player.y - minAbs(player.speedY*dt, distanseToObstacle("up"))
    else
        player.y = player.y - minAbs(player.speedY*dt, -distanseToObstacle("down"))
    end
end