--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 17.03.2017
-- Time: 15:26
-- To change this template use File | Settings | File Templates.
--

enemies = {}

local number = 3

for i=1, number do
    enemies[i] = {
        x = 0,
        y = 0,
        speed = 150,
        speedX = 0,
        width = 20,
        height = 32
    }
end

return enemies