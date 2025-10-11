---@diagnostic disable: lowercase-global

--[[
    go over all drivers that currently are in the server.
    get their nationality and name.
    draw it in the main script.
    if a player joins, repeat.
]]

--local isPlayer = not _car.isHidingLabels
local playerNationality = '' ---@type string?
local playerName = '' ---@type string?

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
