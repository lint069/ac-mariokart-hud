
---@diagnostic disable: lowercase-global


function utf8len(s)
  local _, count = string.gsub(s, "[^\128-\191]", "")
  return count
end

local settings = ac.storage{}


function script.windowMain()

end

function script.Draw3D()

end