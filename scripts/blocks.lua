--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 18:29
-- To change this template use File | Settings | File Templates.
--

blocks = {}

local size = 32

function blocks.getSizeOfBlock() return size end
local nameIDs = {}

blocks[0] = {
    name = "void",
    draw = function(x, y)
    end
}
blocks[1] = {
    name = "dirt",
    sprite = love.graphics.newImage("images/dirt.png"),
    draw = function(self, x, y)
        self.sprite:setFilter("nearest","nearest")
        love.graphics.draw(self.sprite, x*size, y*size, 0, 2)
    end
}

for i=1, #blocks do
    nameIDs[blocks[i].name] = i
end

function blocks.getBlockByName(name)
    return blocks[nameIDs[name]]
end

function blocks.getBlockIDByName(name) return nameIDs[name] end
return blocks