-- Lemon Hub (All Features)
-- Load via: loadstring(game:HttpGet("URL"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ===== CONFIG =====
local config = {
    SpeedBoost = false,
    SpeedValue = 50,
    Fly = false,
    FlySpeed = 50,
    SpinBot = false,
    SpinSpeed = 10,
    Galaxy = false,
    ESP = false,
    Aimbot = false,
    AimFOV = 60,
    AimSmooth = 0.25,
    Teleport = false,
    AutoFarm = false
}

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

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 300, 0, 40)
title.Position = UDim2.new(0, 20, 0, 10)
title.BackgroundTransparency = 1
title.Text = "🍋 Lemon Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = topBar

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

local pageMain = createPage("Main")
local pageMisc = createPage("Misc")
local pageSettings = createPage("Settings")

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

-- Helpers
local function createToggle(parent, text, default, callback)
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
    btn.BackgroundColor3 = default and Color3.fromRGB(120, 220, 120) or Color3.fromRGB(50, 50, 70)
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    local state = default
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
    sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
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

-- ========= MAIN PAGE FEATURES =========
-- Speed Boost
createToggle(pageMain, "Speed Boost", false, function(state)
    config.SpeedBoost = state
    humanoid.WalkSpeed = state and config.SpeedValue or 16
end)

createSlider(pageMain, "Speed Value", 16, 100, config.SpeedValue, function(val)
    config.SpeedValue = val
    if config.SpeedBoost then
        humanoid.WalkSpeed = val
    end
end)

-- Fly
local flying = false
local flyBodyVelocity

createToggle(pageMain, "Fly", false, function(state)
    flying = state
    config.Fly = state

    if state then
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.Parent = character.PrimaryPart
    else
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
    end
end)

createSlider(pageMain, "Fly Speed", 10, 200, config.FlySpeed, function(val)
    config.FlySpeed = val
end)

-- Spin Bot
local spinEnabled = false
local spinSpeed = 10

createToggle(pageMain, "Spin Bot", false, function(state)
    spinEnabled = state
    config.SpinBot = state
end)

createSlider(pageMain, "Spin Speed", 1, 40, spinSpeed, function(val)
    spinSpeed = val
    config.SpinSpeed = val
end)

RunService.RenderStepped:Connect(function()
    if spinEnabled and character.PrimaryPart then
        character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0))
    end

    if flying and character.PrimaryPart then
        local move = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            move = move + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            move = move - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            move = move - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            move = move + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            move = move + Vector3.new(0,1,0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            move = move - Vector3.new(0,1,0)
        end

        flyBodyVelocity.Velocity = move.Unit * config.FlySpeed
    end
end)

-- ========= MISC PAGE FEATURES =========
-- Galaxy Mode
createToggle(pageMisc, "Galaxy Mode", false, function(state)
    config.Galaxy = state
    game.Lighting.Ambient = state and Color3.fromRGB(120, 80, 255) or Color3.fromRGB(255, 255, 255)
end)

-- ESP
local espFolder = Instance.new("Folder")
espFolder.Name = "ESP"
espFolder.Parent = LemonHub

local function createESP(plr)
    local esp = Instance.new("BillboardGui")
    esp.Name = "ESP_"..plr.Name
    esp.Size = UDim2.new(0, 200, 0, 50)
    esp.Adornee = plr.Character and plr.Character:FindFirstChild("Head")
    esp.AlwaysOnTop = true
    esp.Parent = espFolder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = plr.Name
    label.TextColor3 = Color3.fromRGB(255, 255, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = esp

    return esp
end

local espList = {}

createToggle(pageMisc, "ESP", false, function(state)
    config.ESP = state

    if state then
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
                espList[plr.Name] = createESP(plr)
            end
        end
    else
        for _,gui in pairs(espFolder:GetChildren()) do
            gui:Destroy()
        end
        espList = {}
    end
end)

Players.PlayerAdded:Connect(function(plr)
    if config.ESP then
        espList[plr.Name] = createESP(plr)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if espList[plr.Name] then
        espList[plr.Name]:Destroy()
        espList[plr.Name] = nil
    end
end)

-- Aimbot
local function getClosestPlayer()
    local closest, closestDist = nil, math.huge

    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
            local pos, onScreen = camera:WorldToViewportPoint(plr.Character.Head.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                if dist < closestDist and dist <= config.AimFOV then
                    closestDist = dist
                    closest = plr
                end
            end
        end
    end

    return closest
end

local aimLock = false

createToggle(pageMisc, "Aimbot", false, function(state)
    config.Aimbot = state
    aimLock = state
end)

createSlider(pageMisc, "Aim FOV", 10, 200, config.AimFOV, function(val)
    config.AimFOV = val
end)

createSlider(pageMisc, "Aim Smooth", 0, 1, config.AimSmooth, function(val)
    config.AimSmooth = val
end)

RunService.RenderStepped:Connect(function()
    if aimLock then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            local newCFrame = CFrame.new(camera.CFrame.Position, headPos)
            camera.CFrame = camera.CFrame:Lerp(newCFrame, config.AimSmooth)
        end
    end
end)

-- Teleport to player
createToggle(pageSettings, "Teleport Mode", false, function(state)
    config.Teleport = state
end)

createToggle(pageSettings, "Auto Farm", false, function(state)
    config.AutoFarm = state
end)

RunService.RenderStepped:Connect(function()
    if config.Teleport then
        -- Teleport to nearest player
        local closest, dist = nil, math.huge
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local d = (player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = plr
                end
            end
        end
        if closest and closest.Character then
            player.Character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame
        end
    end

    if config.AutoFarm then
        -- Simple auto farm: move to nearest player and punch (if tool exists)
        local closest, dist = nil, math.huge
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local d = (player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = plr
                end
            end
        end

        if closest and closest.Character then
            player.Character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame * CFrame.new(2,0,0)
        end
    end
end)

-- Toggle visibility
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        LemonHub.Enabled = not LemonHub.Enabled
    end
end)
