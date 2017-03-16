--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 17:50
-- To change this template use File | Settings | File Templates.
--

function love.load()
    require "scripts.game"
    game.start()
end

function love.update(dt)
    game.setPlayerSpeed(dt)
    game.setPlayerCoordinates(dt)
end

function love.draw()
    game.drawMap()
    game.drawPlayer()
end