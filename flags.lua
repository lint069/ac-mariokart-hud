---@diagnostic disable: lowercase-global


_flags = {
    Italy   = { ISO = 'it', ratio = 3/2 },
    Germany = { ISO = 'de', ratio = 5/3 },
}

--[[
    go over all drivers that currently are in the server.
    get their nationality and name.
]]

local playerNationality = '' ---@type string?
local playerName = '' ---@type string?

---@return string?, string? @playerName, playerNationality
function getFlagInfo()
    for i=0, _car.index do
        playerName = ac.getDriverName(i)
        playerNationality = ac.getDriverNationality(i)
    end
    return playerName, playerNationality
end

--[[
ac.onClientConnected(function ()
    getFlagInfo()
end)
]]
