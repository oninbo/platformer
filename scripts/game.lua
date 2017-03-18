--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 27.02.2017
-- Time: 14:38
-- To change this template use File | Settings | File Templates.
--

local function minAbs(a, b, c)
    if not c then c = math.huge end
    if math.abs(a) <= math.abs(b) and math.abs(a) <= math.abs(c) then return a
    elseif math.abs(b) <= math.abs(a) and math.abs(b) <= math.abs(c) then return b
    else return c end
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
    love.graphics.setColor(0, 155, 255)
    for x=0, map.width-1 do
        for y=0, map.height-1 do
            local i = map.get(x, y)
            local _x = x*tiles.tileSize
            local _y = y*tiles.tileSize
            tiles.draw(i, _x, _y)
        end
    end
end

local function enemiesOnLine(object)
    local n = 0
    for i = 1, #enemies do
        if enemies[i].y + enemies[i].height == object.y + object.height then
            n = n + 1
        end
    end
    return n
end

function game.setInitialPlayerCoordinates()
    local spawnPoint = map.spawnPoint
    player.x = spawnPoint.x*tiles.tileSize
    player.y = (spawnPoint.y+1)*tiles.tileSize-player.height
end

function game.setInitialEnemiesCoordinates()
    math.randomseed(os.time())
    for i=1, #enemies do
        local x, y
        repeat
            x = math.random(map.width) - 1
            y = math.random(map.height) - 1
            enemies[i].x = x*tiles.tileSize
            enemies[i].y = (y + 1)*tiles.tileSize - enemies[i].height
        until map.get(x, y) == 0 and map.get(x,y + 1) ~= 0 and enemiesOnLine(enemies[i]) == 1
            and map.spawnPoint.x ~= x and map.spawnPoint.y ~= y
    end
end

function game.drawPlayer()
    love.graphics.setColor(0, 255, 105)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

function game.drawEnemies()
    love.graphics.setColor(255, 150, 0)
    for i=1, #enemies do
        love.graphics.rectangle("fill", enemies[i].x, enemies[i].y, enemies[i].width, enemies[i].height)
    end
end

local function intersects(x1, x2, x3, x4)
    if x1 > x2 then
        x1, x2 = x2, x1
    end
    if x3 > x4 then
        x3, x4 = x4, x3
    end
    return (x2 >= x3 and x2 <= x4) or (x1 >= x3 and x1 <= x4)
end

local function getLocation(object)
    return {
        minX = math.floor(object.x / tiles.tileSize),
        maxX = math.ceil((object.x+object.width) / tiles.tileSize)-1,
        minY = math.floor(object.y / tiles.tileSize),
        maxY = math.ceil((object.y + object.height) / tiles.tileSize)-1
    }
end
local function distanseToObstacle(object, direction)
    local player = object
    local locations = getLocation(object)
    local minX = locations.minX
    local maxX = locations.maxX
    local minY = locations.minY
    local maxY = locations.maxY
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
        return math.abs(player.x+player.width - map.width*tiles.tileSize)
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
        return math.abs(player.y+player.height - map.height*tiles.tileSize)
    end
end
local function distanceToEdge(object, direction)
    local locations = getLocation(object)
    local minX = locations.minX
    local maxX = locations.maxX
    local y = locations.maxY + 1
    if direction == "left" then
        for x = minX, 0, -1 do
            if map.get(x, y) == 0 then return math.abs(object.x - (x+1)*tiles.tileSize) end
        end
        return math.abs(object.x)
    elseif direction == "right" then
        for x = maxX, map.width do
            if map.get(x, y) == 0 then return math.abs(object.x+object.width - x*tiles.tileSize) end
        end
        return math.abs(object.x+object.width - map.width*tiles.tileSize)
    end
end
local function distanceToEnemy(object, direction)
    local distance = math.huge
    for i = 1, #enemies do
        local enemy = enemies[i]
        if direction == "left" and object.x - enemy.x >=0 and intersects(object.y, object.y + object.height, enemy.y, enemy.y + enemy.height) then
            distance = math.min(distance, object.x - enemy.x - enemy.width)
        elseif direction == "right" and enemy.x - object.x>=0 and intersects(object.y, object.y + object.height, enemy.y, enemy.y + enemy.height) then
            distance = math.min(distance, enemy.x - object.x - object.width)
        elseif direction == "up" and object.y - enemy.y>=0 and intersects(object.x, object.x + object.width, enemy.x, enemy.x + enemy.width) then
            distance = math.min(distance, object.y - enemy.y - enemy.height)
        elseif direction == "down" and enemy.y - object.y>=0 and intersects(object.x, object.x + object.width, enemy.x, enemy.x + enemy.width) then
            distance = math.min(distance, enemy.y - object.y - object.height)
        end
    end
    return distance
end

local function collide(object1, object2)
    local o1x0 = object1.x
    local o1x1 = object1.x + object1.width
    local o2x0 = object2.x
    local o2x1 = object2.x + object2.width
    local o1y0 = object1.y
    local o1y1 = object1.y + object1.height
    local o2y0 = object2.y
    local o2y1 = object2.y + object2.height
    return ((o1x0 <= o2x1 and o1x0 >= o2x0) or (o1x1 <= o2x1 and o1x1 >= o2x0)) and
            ((o1y0 <= o2y1 and o1y0 >= o2y0) or (o1y1 <= o2y1 and o1y1 >= o2y0))
end

function game.setPlayerSpeed(dt)
    if distanseToObstacle(player, "left") == 0 or distanseToObstacle(player, "right") == 0 then
        player.speedX = 0
        player.running = false
    end
    if love.keyboard.isDown("left") then
        if player.speedX == 0 then
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

    if distanseToObstacle(player, "up") == 0 or distanseToObstacle(player, "down") == 0 then
        player.speedY = 0
        player.jumping = false
    end
    if love.keyboard.isDown("space") then
        if distanseToObstacle(player, "down") == 0 then
            player.jumping = true
            player.speedY = -player.jumpSpeed
        end
    else
        player.jumping = false
    end
    if player.jumping then
        player.speedY = player.speedY - player.jumpAcceleration*dt
    end
    player.speedY = player.speedY + G*dt
end
function game.setPlayerCoordinates(dt)
    if player.speedX > 0 then
        player.x = player.x + minAbs(player.speedX*dt, distanseToObstacle(player, "right"), distanceToEnemy(player, "right"))
    else
        player.x = player.x + minAbs(player.speedX*dt, -distanseToObstacle(player, "left"), -distanceToEnemy(player, "left"))
    end
    if player.speedY > 0 then
        player.y = player.y + minAbs(player.speedY*dt, distanseToObstacle(player, "down"), distanceToEnemy(player, "down"))
    else
        player.y = player.y + minAbs(player.speedY*dt, -distanseToObstacle(player, "up"), -distanceToEnemy(player, "up"))
    end
end

function game.setEnemiesSpeed(dt)
    for i = 1, #enemies do
        local enemy = enemies[i]
        local leftDistance = math.min(distanseToObstacle(enemy, "left"), distanceToEdge(enemy, "left"))
        local rightDistance = math.min(distanseToObstacle(enemy, "right"), distanceToEdge(enemy, "right"))
        if leftDistance == 0 then
            enemy.speedX = enemy.speed
        elseif rightDistance == 0 then
            enemy.speedX = -enemy.speed
        elseif enemy.speedX == 0 then
            if leftDistance > rightDistance then
                enemy.speedX = -enemy.speed
            else
                enemy.speedX = enemy.speed
            end
        end
    end
end
function game.setEnemiesCoordinates(dt)
    for i = 1, #enemies do
        local enemy = enemies[i]
        local leftDistance = math.min(distanseToObstacle(enemy, "left"), distanceToEdge(enemy, "left"))
        local rightDistance = math.min(distanseToObstacle(enemy, "right"), distanceToEdge(enemy, "right"))
        if enemy.speedX > 0 then
            enemy.x = enemy.x + minAbs(rightDistance, enemy.speedX*dt)
        elseif enemy.speedX < 0 then
            enemy.x = enemy.x + minAbs(-leftDistance, enemy.speedX*dt)
        end
    end
end

function game.checkCollision(dt)
    for i = 1, #enemies do
        local enemy = enemies[i]
        if collide(player, enemy) then
            if player.y + player.height > enemy.y then player.speedX = enemy.speedX - player.speedX end
            enemy.speedX = - enemy.speedX
            player.speedY = - player.speedY
        end
    end
end