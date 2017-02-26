--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 18:29
-- To change this template use File | Settings | File Templates.
--

block = {}

local size = 32
local id
local name
function block.getID() return id end
function block.getName() return name end
function block.getSize() return size end

function block.create(_name)
    name = _name
end