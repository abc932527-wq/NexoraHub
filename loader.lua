--[[
    NexoraHub V2 File Checker
    Copyright © 2026 NexoraHub. All Rights Reserved.

    NON-EXECUTING:
    - Checks remote file availability
    - Checks version
    - Displays file size/status
    - Handles errors
    - Notifies about updates
]]

local CONFIG = {
    CURRENT_VERSION = "1.0.0",

    SCRIPT_URL =
        "https://raw.githubusercontent.com/abc932527-wq/NexoraHub/main/script/StealAnEgg.lua",

    VERSION_URL =
        "https://raw.githubusercontent.com/abc932527-wq/NexoraHub/main/version.txt"
}

local function log(message)
    print("[NexoraHub] " .. message)
end

local function errorLog(message)
    warn("[NexoraHub] ERROR: " .. message)
end

local function getRemote(url)
    local ok, result = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok then
        return false, tostring(result)
    end

    if type(result) ~= "string" or #result == 0 then
        return false, "Empty response"
    end

    return true, result
end

local function normalizeVersion(version)
    if not version then
        return nil
    end

    version = tostring(version)
        :gsub("%s+", "")
        :gsub("\r", "")
        :gsub("\n", "")

    return version
end

local function versionNumber(version)
    local major, minor, patch = version:match("^(%d+)%.(%d+)%.(%d+)$")

    if not major then
        return nil
    end

    return tonumber(major) * 1000000
        + tonumber(minor) * 1000
        + tonumber(patch)
end

print("========================================")
print("          NexoraHub V2 Checker")
print("========================================")

log("Current version: " .. CONFIG.CURRENT_VERSION)
log("Checking remote file...")

-- File availability check
local fileOK, fileResult = getRemote(CONFIG.SCRIPT_URL)

if not fileOK then
    errorLog("Remote file is unavailable.")
    errorLog(fileResult)
else
    log("STATUS: AVAILABLE")
    log("File size: " .. #fileResult .. " bytes")
end

-- Version check
log("Checking latest version...")

local versionOK, remoteVersion = getRemote(CONFIG.VERSION_URL)

if not versionOK then
    errorLog("Could not retrieve version information.")
else
    remoteVersion = normalizeVersion(remoteVersion)

    if not remoteVersion then
        errorLog("Invalid version information.")
    else
        log("Latest version: " .. remoteVersion)

        local currentNumber = versionNumber(CONFIG.CURRENT_VERSION)
        local remoteNumber = versionNumber(remoteVersion)

        if currentNumber and remoteNumber then
            if remoteNumber > currentNumber then
                warn(
                    "[NexoraHub] UPDATE AVAILABLE: "
                    .. CONFIG.CURRENT_VERSION
                    .. " -> "
                    .. remoteVersion
                )
            elseif remoteNumber == currentNumber then
                log("STATUS: UP TO DATE")
            else
                log("STATUS: Local version is newer.")
            end
        else
            log("Version format could not be compared.")
        end
    end
end

print("========================================")
log("Check completed.")
print("========================================")
