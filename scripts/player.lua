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
    size = 16,
    speed = 30
}

function player.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
end

return player