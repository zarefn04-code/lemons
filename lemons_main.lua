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

	toggle.MouseButton1Click:Connect(function()
		callback()
	end)

	return toggle
end

-- Slider helper
local function createSlider(text, y, min, max, default, callback)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 180, 0, 30)
	label.Position = UDim2.new(0, 20, 0, y)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextScaled = true
	label.Font = Enum.Font.Gotham
	label.Parent = mainFrame

	local slider = Instance.new("Frame")
	slider.Size = UDim2.new(0, 260, 0, 30)
	slider.Position = UDim2.new(0, 140, 0, y)
	slider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	slider.Parent = mainFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = slider

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
	bar.BackgroundColor3 = Color3.fromRGB(170, 70, 255)
	bar.Parent = slider

	local valueText = Instance.new("TextLabel")
	valueText.Size = UDim2.new(0, 60, 0, 30)
	valueText.Position = UDim2.new(0, 205, 0, 0)
	valueText.BackgroundTransparency = 1
	valueText.Text = tostring(default)
	valueText.TextColor3 = Color3.fromRGB(255, 255, 255)
	valueText.TextScaled = true
	valueText.Font = Enum.Font.GothamBold
	valueText.Parent = slider

	local dragging = false
	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	slider.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	slider.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local mouse = UserInputService:GetMouseLocation()
			local relative = math.clamp((mouse.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
			local value = math.floor(min + (max-min)*relative)

			bar.Size = UDim2.new(relative, 0, 1, 0)
			valueText.Text = tostring(value)
			callback(value)
		end
	end)

	return slider
end

-- ===== UI ELEMENTS =====
local speedToggle = createToggle("Speed Boost", 90, function()
	config.SpeedBoost = not config.SpeedBoost
	speedToggle.Text = config.SpeedBoost and "ON" or "OFF"
	speedToggle.BackgroundColor3 = config.SpeedBoost and Color3.fromRGB(170, 70, 255) or Color3.fromRGB(80, 80, 90)
end)

local speedSlider = createSlider("Boost Speed", 140, 10, 60, config.BoostSpeed, function(val)
	config.BoostSpeed = val
end)

local spinToggle = createToggle("Spin Bot", 200, function()
	config.SpinBot = not config.SpinBot
	spinToggle.Text = config.SpinBot and "ON" or "OFF"
	spinToggle.BackgroundColor3 = config.SpinBot and Color3.fromRGB(170, 70, 255) or Color3.fromRGB(80, 80, 90)
end)

local spinSlider = createSlider("Spin Speed", 250, 1, 25, config.SpinSpeed, function(val)
	config.SpinSpeed = val
end)

local galaxyToggle = createToggle("Galaxy Mode", 310, function()
	config.GalaxyMode = not config.GalaxyMode
	galaxyToggle.Text = config.GalaxyMode and "ON" or "OFF"
	galaxyToggle.BackgroundColor3 = config.GalaxyMode and Color3.fromRGB(170, 70, 255) or Color3.fromRGB(80, 80, 90)
end)

-- ===== FUNCTIONALITY =====
RunService.RenderStepped:Connect(function(dt)
	-- Speed Boost
	if config.SpeedBoost then
		humanoid.WalkSpeed = config.BoostSpeed
	else
		humanoid.WalkSpeed = 16
	end

	-- Spin Bot
	if config.SpinBot then
		character.PrimaryPart.CFrame = character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(config.SpinSpeed), 0)
	end

	-- Galaxy Mode
	if config.GalaxyMode then
		game.Lighting.Ambient = Color3.fromRGB(120, 80, 255)
	else
		game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
	end
end)

-- Toggle UI visibility
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightShift then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

print("LEMONS UI loaded!")

