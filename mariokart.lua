---@diagnostic disable: lowercase-global


function utf8len(str)
    local _, count = string.gsub(str, "[^\128-\191]", "")
    return count
end

local settings = ac.storage{
    enabled = false,
}

_sim = ac.getSim()
_car = ac.getCar(0)

function script.windowMain()
    ui.setCursor(vec2(10, 30))
    if ui.checkbox('enabled', settings.enabled) then
        settings.enabled = not settings.enabled
    end
end

function script.Draw3D()
    if not settings.enabled then return end

    local carPos = _car.position
    local camSide, camUp = ac.getCameraSide(), ac.getCameraUp()

    local p1 = carPos:add(vec3(0, 2, 0), vec3()) - camSide*0.5 + camUp*0.5
    local p2 = carPos:add(vec3(0, 2, 0), vec3()) + camSide*0.5 + camUp*0.5
    local p3 = carPos:add(vec3(0, 2, 0), vec3()) + camSide*0.5 - camUp*0.5
    local p4 = carPos:add(vec3(0, 2, 0), vec3()) - camSide*0.5 - camUp*0.5

    render.quad(p1, p2, p3, p4, rgbm(1, 1, 1, 1), "assets/mk-8/arrow.png")
end