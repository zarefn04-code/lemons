
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- ===== CONFIG =====
local config = {
    SpeedBoost = false,
    SpeedValue = 50,
    SpinBot = false,
    SpinSpeed = 10,
    Galaxy = false,
    Keybind = Enum.KeyCode.RightShift
}

-- ===== SAVE / LOAD =====
local function saveConfig()
    local data = HttpService:JSONEncode(config)
    pcall(function()
        writefile and writefile("LemonHubConfig.json", data)
    end)
end

local function loadConfig()
    pcall(function()
        if readfile the


