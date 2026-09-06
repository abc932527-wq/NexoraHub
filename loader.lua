--[[
    NexoraHub Loader
    Copyright © 2026 NexoraHub. All Rights Reserved.
]]

local URL = "https://raw.githubusercontent.com/Nexora1987/Nexorahub/main/StealAnEgg.lua"

local ok, result = pcall(function()
    return loadstring(game:HttpGet(URL))()
end)

if not ok then
    warn("[NexoraHub] Failed to load StealAnEgg.lua")
    warn("[NexoraHub] Error: " .. tostring(result))
end
