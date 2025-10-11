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
    debug = false,
}

_sim = ac.getSim()
_car = ac.getCar(_sim.focusedCar)

function script.windowMain()
    ui.setCursor(vec2(10, 30))
    if ui.checkbox('enabled', settings.enabled) then
        settings.enabled = not settings.enabled
    end
end

function script.Draw3D()
    if not settings.enabled then return end

    local carPos = _car.position

    local arrowPos = carPos + vec3(0, 1.75, 0)
    local p1, p2, p3, p4 = makeBillboardQuad(arrowPos, 0.4, 0.4)
    render.quad(p1, p2, p3, p4, rgbm(1, 1, 1, 1), "assets/mk-8/arrow.png")

    local camSide = ac.getCameraSide()
    local flagOffset = camSide * 0.8
    local flagPos = arrowPos + flagOffset + vec3(0, 0.35, 0)

    local p1, p2, p3, p4 = makeBillboardQuad(flagPos, 0.3, 0.17)
    local playerName, playerNationality = getFlagInfo()
    render.quad(p1, p2, p3, p4, nil, "assets/flags/de.png")
end