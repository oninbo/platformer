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

local G = 900
local friction = 500

game = {}

function game.start()
    require "scripts.map"
    require "scripts.tiles"

    love.window.setTitle("My Platformer")
    love.window.setMode(tiles.tileSize*map.width, tiles.tileSize*map.height, {resizable=false, vsync=true})

    require "scripts.player"
    game.setInitialPlayerCoordinates()
    require "scripts.enemies"
    game.setInitialEnemiesCoordinates()
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
    player.x = spawnPoint.x*tiles.tileSize
    player.y = spawnPoint.y*tiles.tileSize-player.height
end

function game.setInitialEnemiesCoordinates()
    math.randomseed(os.time())
    for i=1, #enemies do
        local x, y
        repeat
            x = math.random(map.width) - 1
            y = math.random(map.height) - 1
        until map.get(x, y) == 0 and map.get(x,y + 1) ~= 0
        enemies[i].x = x*tiles.tileSize
        enemies[i].y = (y + 1)*tiles.tileSize - enemies[i].height
    end
end

function game.drawPlayer()
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

function game.drawEnemies()
    for i=1, #enemies do
        love.graphics.rectangle("fill", enemies[i].x, enemies[i].y, enemies[i].width, enemies[i].height)
    end
end

local function distanseToObstacle(direction)
    local minX = math.floor(player.x / tiles.tileSize)
    local maxX = math.ceil((player.x+player.width) / tiles.tileSize)-1
    local minY = math.floor(player.y / tiles.tileSize)
    local maxY = math.ceil((player.y + player.height) / tiles.tileSize)-1
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
                if map.get(x, y) ~= 0 then return math.abs(player.x+player.width - x*tiles.tileSize) end
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
                if map.get(x, y) ~= 0 then return math.abs(player.y+player.height - y*tiles.tileSize) end
            end
        end
        return math.abs(player.y+player.size - map.height*tiles.tileSize)
    end
end

function game.setPlayerSpeed(dt)
    if distanseToObstacle("left") == 0 or distanseToObstacle("right") == 0 then
        player.speedX = 0
        player.running = false
    end
    if love.keyboard.isDown("left") then
        if player.speedX == 0 then
            --player.speedX = -player.speed
            player.running = true
        end
        if player.running and player.speedX > -player.speed then
            player.speedX = player.speedX - player.acceleration*dt
        end
    elseif love.keyboard.isDown("right") then
        if player.speedX == 0 then
            --player.speedX = player.speed
            player.running = true
        end
        if player.running and player.speedX < player.speed then
            player.speedX = player.speedX + player.acceleration*dt
        end
    else
        player.running = false
    end
    if player.speedX > 0 then
        player.speedX = player.speedX - math.min(friction*dt, player.speedX)
    elseif player.speedX < 0 then
        player.speedX = player.speedX + math.min(friction*dt, math.abs(player.speedX))
    end

    if distanseToObstacle("up") == 0 or distanseToObstacle("down") == 0 then
        player.speedY = 0
        player.jumping = false
    end
    if love.keyboard.isDown("space") then
        if distanseToObstacle("down") == 0 then
            player.jumping = true
            player.speedY = player.jumpSpeed
        end
        if player.jumping then
            player.speedY = player.speedY + player.jumpAcceleration*dt
        end
    else
        player.jumping = false
    end
    player.speedY = player.speedY - G*dt
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