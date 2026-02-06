-- Lemon Hub (Canvas GUI)
-- Load via: loadstring(game:HttpGet("URL"))()

--[[
   DISCLAIMER:
   This script is intended for environments that allow loadstring + HttpGet.
   If you're running in Roblox Studio normally, it will not work.
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- ========== MAIN UI ==========
local LemonHub = Instance.new("ScreenGui")
LemonHub.Name = "LemonHub"
LemonHub.ResetOnSpawn = false
LemonHub.Parent = player:WaitForChild("PlayerGui")

-- Canvas
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

-- Top bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 60)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
topBar.BorderSizePixel = 0
topBar.Parent = canvas

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 15)
topCorner.Parent = topBar

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
subtitle.Text = "Powered by Lemon"
subtitle.TextColor3 = Color3.fromRGB(180, 180, 255)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = topBar

-- Close button
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

-- ========== SIDE MENU ==========
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

-- Create a tab button
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

-- ========== MAIN CONTENT ==========
local content = Instance.new("Frame")
content.Size = UDim2.new(0, 660, 0, 490)
content.Position = UDim2.new(0, 240, 0, 60)
content.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
content.BorderSizePixel = 0
content.Parent = canvas

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 15)
contentCorner.Parent = content

-- Content pages
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

-- Activate page
local function setPage(name)
    for k,v in pairs(pages) do
        v.Visible = false
    end
    if pages[name] then
        pages[name].Visible = true
    end
end

-- Create pages
local pageMain = createPage("Main")
local pageMisc = createPage("Misc")

-- Create tabs
local tabMain = createTab("Main")
local tabMisc = createTab("Misc")

tabMain.MouseButton1Click:Connect(function()
    setPage("Main")
end)

tabMisc.MouseButton1Click:Connect(function()
    setPage("Misc")
end)

-- Default page
setPage("Main")

-- ========== CONTENT HELPERS ==========
local function createToggle(parent, text, callback)
    local f



