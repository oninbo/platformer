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
    speed = 100,
    jumpSpeed = 300,
    jumpHeight = 200,
    jumping = false,
    speedX = 0,
    speedY = 0,
    sprite = "yellow block"
}

function player.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
end

function player.setCoordinates(x, y) player.x = x player.y = y end

return player