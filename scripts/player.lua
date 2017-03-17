--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 27.02.2017
-- Time: 15:21
-- To change this template use File | Settings | File Templates.
--

player = {
    x = 0,
    y = 0,
    size = 25,
    width = 25,
    height = 30,
    speed = 200,
    running = false,
    acceleration = 1000,
    jumpAcceleration = 530,
    jumpSpeed = 360,
    jumping = false,
    speedX = 0,
    speedY = 0,
    sprite = "yellow block"
}

function player.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

function player.setCoordinates(x, y) player.x = x player.y = y end

return player