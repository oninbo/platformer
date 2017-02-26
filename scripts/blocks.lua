--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 26.02.2017
-- Time: 18:29
-- To change this template use File | Settings | File Templates.
--

blocks = {}
local sha = require "sha-256"

function blocks.add(_name, _sprite)
    local hash = sha.hash256(_name)
    blocks[hash] = {
        name = _name,
        sprite = _sprite,
        id = hash
    }
end

function blocks.get(_name)
    local hash = sha.hash256(_name)
    return blocks[hash]
end

return blocks