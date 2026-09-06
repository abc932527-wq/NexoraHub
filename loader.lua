--[[
    NexoraHub File Checker
    Copyright © 2026 NexoraHub. All Rights Reserved.

    This loader ONLY checks whether the remote file is available.
    It does NOT execute or load the downloaded Lua code.
]]

local URL = "https://raw.githubusercontent.com/abc932527-wq/NexoraHub/main/script/StealAnEgg.lua"

print("================================")
print("       NexoraHub Checker")
print("================================")
print("[NexoraHub] Checking file...")
print("[NexoraHub] URL: " .. URL)

local ok, response = pcall(function()
    return game:HttpGet(URL)
end)

if ok and type(response) == "string" and #response > 0 then
    print("[NexoraHub] STATUS: AVAILABLE")
    print("[NexoraHub] File was successfully retrieved.")
    print("[NexoraHub] Size: " .. #response .. " bytes")
else
    warn("[NexoraHub] STATUS: UNAVAILABLE")
    warn("[NexoraHub] Could not retrieve the file.")
end

print("================================")
