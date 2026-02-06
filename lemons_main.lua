-- LEMONS UI (Roblox LocalScript)
-- Load via: loadstring(game:HttpGet("URL"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- ===== CONFIG =====
local config = {
	SpeedBoost = false,
	BoostSpeed = 30,
	SpinBot = false,
	SpinSpeed = 10,
	GalaxyMode = false,
}

-- ===== UI CREATION =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LemonsGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 520)
mainFrame.Position = UDim2.new(0.5, -210, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "LEMONS"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 30)
subtitle.BackgroundTransparency = 1
subtitle.Text = "discord.gg/22s"
subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = header

-- Toggle button helper
local function createToggle(text, y, callback)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 180, 0, 30)
	label.Position = UDim2.new(0, 20, 0, y)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextScaled = true
	label.Font = Enum.Font.Gotham
	label.Parent = mainFrame

	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 60, 0, 30)
	toggle.Position = UDim2.new(0, 330, 0, y)
	toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
	toggle.Text = "OFF"
	toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggle.Font = Enum.Font.GothamBold
	toggle.TextScaled = true
	toggle.Parent = mainFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = toggle

	-- FIX: Use both click types to ensure compatibility
	toggle.MouseButton1Click:Connect(function()
		callback()
	end)

	toggle.MouseButton1Down:Connect(function()
		callback()
	end)

	return toggle
end

-- Slider helper
local function cr


