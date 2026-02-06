-- Lemon Hub (Canvas GUI)
-- Load via: loadstring(game:HttpGet("URL"))()

--[[
   WARNING:
   This script requires loadstring + HttpGet.
   This will NOT run in standard Roblox Studio.
--]]

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
        if readfile then
            local data = readfile("LemonHubConfig.json")
            config = HttpService:JSONDecode(data)
        end
    end)
end

loadConfig()

-- ===== UI =====
local LemonHub = Instance.new("ScreenGui")
LemonHub.Name = "LemonHub"
LemonHub.ResetOnSpawn = false
LemonHub.Parent = player:WaitForChild("PlayerGui")

local canvas = Instance.new("Frame")
canvas.Name = "Canvas"
canvas.Size = UDim2.new(0, 900, 0, 550)
canvas.Position = UDim2.new(0.5, -450, 0.5, -275)
canvas.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
canvas.BorderSizePixel = 0
canvas.Active = true
canvas.Draggable = true
canvas.Parent = LemonHub

local canvasCorner = Instance.new("UICorner")
canvasCorner.CornerRadius = UDim.new(0, 15)
canvasCorner.Parent = canvas

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 60)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
topBar.BorderSizePixel = 0
topBar.Parent = canvas

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 15)
topCorner.Parent = topBar

-- Gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
})
gradient.Rotation = 90
gradient.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 300, 0, 40)
title.Position = UDim2.new(0, 20, 0, 10)
title.BackgroundTransparency = 1
title.Text = "🍋 Lemon Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = topBar

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0, 300, 0, 20)
subtitle.Position = UDim2.new(0, 20, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Modern UI • Smooth animations"
subtitle.TextColor3 = Color3.fromRGB(230, 230, 255)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 60, 0, 30)
closeButton.Position = UDim2.new(1, -70, 0, 15)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255,255,255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
closeButton.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    LemonHub.Enabled = false
end)

-- Side Menu
local sideMenu = Instance.new("Frame")
sideMenu.Size = UDim2.new(0, 220, 0, 490)
sideMenu.Position = UDim2.new(0, 0, 0, 60)
sideMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
sideMenu.BorderSizePixel = 0
sideMenu.Parent = canvas

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 15)
sideCorner.Parent = sideMenu

local menuLayout = Instance.new("UIListLayout")
menuLayout.Padding = UDim.new(0, 10)
menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
menuLayout.Parent = sideMenu

local menuTitle = Instance.new("TextLabel")
menuTitle.Size = UDim2.new(1, 0, 0, 40)
menuTitle.BackgroundTransparency = 1
menuTitle.Text = "MENU"
menuTitle.TextColor3 = Color3.fromRGB(200,200,255)
menuTitle.TextScaled = true
menuTitle.Font = Enum.Font.GothamBold
menuTitle.Parent = sideMenu

-- Search Bar
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -20, 0, 35)
searchBox.Position = UDim2.new(0, 10, 0, 420)
searchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
searchBox.PlaceholderText = "Search..."
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(255,255,255)
searchBox.TextScaled = true
searchBox.Font = Enum.Font.Gotham
searchBox.Parent = sideMenu

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 10)
searchCorner.Parent = searchBox

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(0, 660, 0, 490)
content.Position = UDim2.new(0, 240, 0, 60)
content.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
content.BorderSizePixel = 0
content.Parent = canvas

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 15)
contentCorner.Parent = content

-- Pages
local pages = {}
local function createPage(name)
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    pages[name] = page
    return page
end

local function setPage(name)
    for k,v in pairs(pages) do
        v.Visible = false
    end
    if pages[name] then
        pages[name].Visible = true
    end
end

-- Tabs
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.Parent = sideMenu

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = btn

    return btn
end

-- Create pages
local pageMain = createPage("Main")
local pageMisc = createPage("Misc")
local pageSettings = createPage("Settings")

-- Create tabs
local tabMain = createTab("Main")
local tabMisc = createTab("Misc")
local tabSettings = createTab("Settings")

tabMain.MouseButton1Click:Connect(function()
    setPage("Main")
end)
tabMisc.MouseButton1Click:Connect(function()
    setPage("Misc")
end)
tabSettings.MouseButton1Click:Connect(function()
    setPage("Settings")
end)

setPage("Main")

-- Content helper functions
local function createToggle(parent, text, state, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, 0, 0.6, 0)
    btn.Position = UDim2.new(0.72, 0, 0.2, 0)
    btn.BackgroundColor3 = state and Color3.fromRGB(120, 220, 120) or Color3.fromRGB(50, 50, 70)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(120, 220, 120) or Color3.fromRGB(50, 50, 70)
        callback(state)
    end)
end

local function createSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 60)
    frame.Position = UDim2.new(0, 10, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = frame

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, 0, 0, 25)
    sliderBg.Position = UDim2.new(0, 0, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBg.Parent = frame

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(120, 220, 120)
    sliderFill.Parent = sliderBg

    local valueText = Instance.new("TextLabel")
    valueText.Size = UDim2.new(0, 60, 0, 25)
    valueText.Position = UDim2.new(1, -70, 0, 30)
    valueText.BackgroundTransparency = 1
    valueText.Text = tostring(default)
    valueText.TextColor3 = Color3.fromRGB(255,255,255)
    valueText.TextScaled = true
    valueText.Font = Enum.Font.GothamBold
    valueText.Parent = frame

    local dragging = false

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    sliderBg.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = sliderBg.AbsolutePosition
            local size = sliderBg.AbsoluteSize
            local mousePos = UserInputService:GetMouseLocation()
            local relative = math.clamp((mousePos.X - pos.X) / size.X, 0, 1)

            sliderFill.Size = UDim2.new(relative, 0, 1, 0)
            local value = math.floor(min + (max - min) * relative)
            valueText.Text = tostring(value)
            callback(value)
        end
    end)
end

-- Layouts
local mainLayout = Instance.new("UIListLayout")
mainLayout.Padding = UDim.new(0, 10)
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Parent = pageMain

local miscLayout = Instance.new("UIListLayout")
miscLayout.Padding = UDim.new(0, 10)
miscLayout.SortOrder = Enum.SortOrder.LayoutOrder
miscLayout.Parent = pageMisc

local settingsLayout = Instance.new("UIListLayout")
settingsLayout.Padding = UDim.new(0, 10)
settingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
settingsLayout.Parent = pageSettings

-- Main Page
createToggle(pageMain, "Speed Boost", config.SpeedBoost, function(state)
    config.SpeedBoost = state
    humanoid.WalkSpeed = state and config.SpeedValue or 16
    saveConfig()
end)

createSlider(pageMain, "Speed Value", 16, 100, config.SpeedValue, function(val)
    config.SpeedValue = val
    if config.SpeedBoost then
        humanoid.WalkSpeed = val
    end
    saveConfig()
end)

local spinEnabled = config.SpinBot
local spinSpeed = config.SpinSpeed

createToggle(pageMain, "Spin Bot", config.SpinBot, function(state)
    spinEnabled = state
    config.SpinBot = state
    saveConfig()
end)

createSlider(pageMain, "Spin Speed", 1, 40, config.SpinSpeed, function(val)
    spinSpeed = val
    config.SpinSpeed = val
    saveConfig()
end)

RunService.RenderStepped:Connect(function()
    if spinEnabled and character.PrimaryPart then
        character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0))
    end
end)

-- Misc Page
createToggle(pageMisc, "Galaxy Mode", config.Galaxy, function(state)
    config.Galaxy = state
    game.Lighting.Ambient = state and Color3.fromRGB(120, 80, 255) or Color3.fromRGB(255, 255, 255)
    saveConfig()
end)

-- Settings Page
createToggle(pageSettings, "Save Config", true, function(state)
    if state then
        saveConfig()
    end
end)

-- Toggle visibility
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == config.Keybind then
        LemonHub.Enabled = not LemonHub.Enabled
    end
end)

