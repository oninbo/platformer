--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 18:29
-- To change this template use File | Settings | File Templates.
--

blocks = {}

local nameIDs = {}

blocks[1] = {
    name = "dirt"
}

for i=1, #blocks do
    nameIDs[blocks[i].name] = i
end

function blocks.getBlockByName(name)
    return blocks[nameIDs[name]]
end

function blocks.getBlockIDByName(name) return nameIDs[name] end
return blocks