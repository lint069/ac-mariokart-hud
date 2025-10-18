---@diagnostic disable: lowercase-global, redefined-local


require 'flags'

function utf8len(s)
    local _, len = string.gsub(s, "[^\128-\191]", "")
    return len
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

local sim = ac.getSim()
local assetsPath = './assets'

function script.windowMain()
    ui.setCursor(vec2(10, 30))
    if ui.checkbox('enabled', settings.enabled) then
        settings.enabled = not settings.enabled
    end
end

function script.Draw3D()
    if not settings.enabled then return end

    local mk8Path = assetsPath .. '/mk8/'
    local mkwPath = assetsPath .. '/mkw/'

    for i = 0, sim.carsCount - 1 do
        local car = ac.getCar(i)
        if car == nil then return end

        if car.isHidingLabels then goto exit end

        local basePos = car.position + vec3(0, car.aabbSize.y + 0.6, 0)

        local p1, p2, p3, p4 = makeBillboardQuad(basePos, 0.4, 0.4)
        render.quad(p1, p2, p3, p4, nil, mk8Path .. "arrow.png")

        ::exit::
    end



    local _, playerNationality

    -- no flag rendering on some?
    for i = 0, sim.carsCount - 1 do
        local car = ac.getCar(i) if car == nil then return end

        _, playerNationality = getPlayerInfo(i)

        if playerNationality and _flag[playerNationality] then
            if car.isHidingLabels then goto exit end

            local basePos = car.position + vec3(0, car.aabbSize.y + 0.6, 0)

            local flagOffset = ac.getCameraSide() * math.clamp(_flag[playerNationality].ratio / 2, 0.65, 0.8) + vec3(0, 0.35, 0)
            local flagPos = basePos + flagOffset

            local flagHeight = 0.2
            local flagWidth = flagHeight * _flag[playerNationality].ratio

            local flagsPath = assetsPath .. '/flags/'
            local p1, p2, p3, p4 = makeBillboardQuad(flagPos, flagWidth, flagHeight)
            render.quad(p1, p2, p3, p4, nil, flagsPath .. _flag[playerNationality].ISO .. ".png")

            ::exit::
        end
    end
end