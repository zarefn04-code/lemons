-- Lemon Hub (Roblox Version)
-- Load with: loadstring(game:HttpGet("URL"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Config
local config = {
    SpeedBoost = false,
    SpeedValue = 50,
    Fly = false,
    FlySpeed = 50,
    Spin = false,
    SpinSpeed = 10,
    ESP = false,
    Aimbot = false,
    AimFOV = 60,
    AimSmooth = 0.2,
    Teleport = false,
    AutoFarm = false,
    Galaxy = false
}

-- UI
local LemonHub = Instance.new("ScreenGui")
LemonHub.Name = "LemonHub"
LemonHub.ResetOnSpawn = false
LemonHub.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 900, 0, 550)
main.Position = UDim2.new(0.5, -450, 0.5, -275)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = LemonHub

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = main

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 60)
top.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
top.BorderSizePixel = 0
top.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 15)
topCorner.Parent = top

local title = Instance.new("TextLabel")
title.Text = "🍋 Lemon Hub"
title.Size = UDim2.new(0, 300, 0, 40)
title.Position = UDim2.new(0, 20, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = top

local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 60, 0, 30)
closeBtn.Position = UDim2.new(1, -70, 0, 15)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,100,100)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.Parent = top

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    LemonHub.Enabled = false
end)

-- Side menu
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 220, 0, 490)
menu.Position = UDim2.new(0, 0, 0, 60)
menu.BackgroundColor3 = Color3.fromRGB(18,18,25)
menu.BorderSizePixel = 0
menu.Parent = main

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 15)
menuCorner.Parent = menu

local menuLayout = Instance.new("UIListLayout")
menuLayout.Padding = UDim.new(0, 10)
menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
menuLayout.Parent = menu

local menuTitle = Instance.new("TextLabel")
menuTitle.Text = "MENU"
menuTitle.Size = UDim2.new(1, 0, 0, 40)
menuTitle.BackgroundTransparency = 1
menuTitle.TextColor3 = Color3.fromRGB(200,200,255)
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextScaled = true
menuTitle.Parent = menu

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(0, 660, 0, 490)
content.Position = UDim2.new(0, 240, 0, 60)
content.BackgroundColor3 = Color3.fromRGB(25,25,35)
content.BorderSizePixel = 0
content.Parent = main

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 15)
contentCorner.Parent = content

-- Pages
local pages = {}
local function createPage(name)
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    pages[name] = page
    return page
end

local function setPage(name)
    for _,v in pairs(pages) do
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
    btn.BackgroundColor3 = Color3.fromRGB(30,30,40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.Parent = menu

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    return btn
end

local pageMain = createPage("Main")
local pageMisc = createPage("Misc")
local pageSettings = createPage("Settings")

local tabMain = createTab("Main")
local tabMisc = createTab("Misc")
local tabSettings = createTab("Settings")

tabMain.MouseButton1Click:Connect(function() setPage("Main") end)
tabMisc.MouseButton1Click:Connect(function() setPage("Misc") end)
tabSettings.MouseButton1Click:Connect(function() setPage("Settings") end)

setPage("Main")

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
settingsLayout.Parent
