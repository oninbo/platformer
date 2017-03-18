--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 17.03.2017
-- Time: 15:26
-- To change this template use File | Settings | File Templates.
--

enemies = {}

local number = 5

for i=1, number do
    enemies[i] = {
        x = 0,
        y = 0,
        speed = 80,
        speedX = 0,
        width = 16,
        height = 16
    }
end

return enemies