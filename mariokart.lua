---@diagnostic disable: lowercase-global, redefined-local


require 'flags'

function utf8len(str)
    local _, count = string.gsub(str, "[^\128-\191]", "")
    return count
end

function makeBillboardQuad(center, hw, hh)
    local camSide, camUp = ac.getCameraSide(), ac.getCameraUp()

    local p1 = center - camSide*hw + camUp*hh
    local p2 = center + camSide*hw + camUp*hh
    local p3 = center + camSide*hw - camUp*hh
    local p4 = center - camSide*hw - camUp*hh

    return p1, p2, p3, p4
end

local settings = ac.storage{
    enabled = false,
}

_car = ac.getCar(0)
_assetsPath = './assets'

function script.windowMain(dt)
    ui.setCursor(vec2(10, 30))
    if ui.checkbox('enabled', settings.enabled) then
        settings.enabled = not settings.enabled
    end
end

function script.Draw3D()
    if not settings.enabled then return end

    local carPos = _car.position
    local mk8Path = _assetsPath .. '/mk8/'
    local mkwPath = _assetsPath .. '/mkw/'

    --#region Arrow

    local arrowPos = carPos + vec3(0, 1.75, 0)
    local p1, p2, p3, p4 = makeBillboardQuad(arrowPos, 0.4, 0.4)
    render.quad(p1, p2, p3, p4, rgbm(1, 1, 1, 1), mk8Path .. "arrow.png")

    --#endregion

    --#region Flag

    --todo: offset for different flag ratios
    local camSide = ac.getCameraSide()
    local flagOffset = camSide * 0.7
    local flagPos = arrowPos + flagOffset + vec3(0, 0.36, 0)

    local _, playerNationality = getFlagInfo()
    local flagHeight = 0.2
    local flagWidth = flagHeight * _flag[playerNationality].ratio

    local flagsPath = _assetsPath .. '/flags/'
    local p1, p2, p3, p4 = makeBillboardQuad(flagPos, flagWidth, flagHeight)
    render.quad(p1, p2, p3, p4, nil, flagsPath .. _flag[playerNationality].ISO .. ".png")

    --#endregion
end