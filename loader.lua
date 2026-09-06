--[[
    © 2026 NexoraHub. All Rights Reserved.
    Unauthorized copying, redistribution, or re-uploading is prohibited.
]]

local URL = "ILAGAY_DITO_ANG_RAW_URL_NG_StealAnEgg.lua"

local success, err = pcall(function()
    loadstring(game:HttpGet(URL))()
end)

if not success then
    warn("[NexoraHub] Failed to load StealAnEgg.lua: " .. tostring(err))
end
