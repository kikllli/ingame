-- ========== OPTIMIZED MLML673 HUB ==========
-- Combined & Ultra-Optimized Script

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Backpack = LocalPlayer:WaitForChild('Backpack')
local Lighting = game:GetService('Lighting')

-- ========== CLEANUP ==========
if game.CoreGui:FindFirstChild('CombinedUI') then
    game.CoreGui:FindFirstChild('CombinedUI'):Destroy()
end

-- ========== OPTIMIZATION ==========
Lighting.GlobalShadows = false
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.Ambient = Color3.fromRGB(128, 128, 128)
Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)

for _, effect in ipairs(Lighting:GetChildren()) do
    if effect:IsA('PostEffect') then
        effect.Enabled = false
    end
end

for _, particle in ipairs(workspace:GetDescendants()) do
    if particle:IsA('ParticleEmitter') then
        particle.Enabled = false
    end
end

-- ========== ACCESSORY REMOVAL ==========
local function RemoveAccessories(character)
    if not character then return end
    for _, item in ipairs(character:GetDescendants()) do
        if item:IsA("Accessory") then
            item:Destroy()
        end
    end
end

local function OnCharacterAdded(character)
    RemoveAccessories(character)
    local connection
    connection = character.DescendantAdded:Connect(function(child)
        if child:IsA("Accessory") then
            child:Destroy()
        end
    end)
    character:WaitForChild("Humanoid").Died:Connect(function()
        connection:Disconnect()
    end)
end

RemoveAccessories(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)

workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA('Humanoid') then
        local parent = descendant.Parent
        RemoveAccessories(parent)
        local conn
        conn = parent.ChildAdded:Connect(function(child)
            if child:IsA('Accessory') then
                child:Destroy()
            end
        end)
        descendant.Died:Connect(function()
            conn:Disconnect()
        end)
    end
end)

-- ========== MAIN GUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CombinedUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- ========== HELPER FUNCTION ==========
local function CreateStyledFrame(size, position, name)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    frame.BorderSizePixel = 0
    frame.Parent = ScreenGui
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 12)
    return frame
end

-- ========== FPS DEVOUR FRAME ==========
local DevourFrame = CreateStyledFrame(UDim2.new(0, 340, 0, 160), UDim2.new(0.5, -170, 0.5, -80), "DevourFrame")
DevourFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

local DevourTitle = Instance.new('TextLabel')
DevourTitle.Parent = DevourFrame
DevourTitle.Size = UDim2.new(1, -20, 0, 40)
DevourTitle.Position = UDim2.new(0, 10, 0, 10)
DevourTitle.BackgroundTransparency = 1
DevourTitle.Text = 'MLML673 FPS DEVOUR'
DevourTitle.Font = Enum.Font.GothamBlack
DevourTitle.TextSize = 20
DevourTitle.TextXAlignment = Enum.TextXAlignment.Left
DevourTitle.TextColor3 = Color3.new(1, 1, 1)

local DevourButton = Instance.new('TextButton')
DevourButton.Parent = DevourFrame
DevourButton.Size = UDim2.new(1, -40, 0, 54)
DevourButton.Position = UDim2.new(0, 20, 0, 80)
DevourButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
DevourButton.Text = 'FPS Devour (need auras)'
DevourButton.Font = Enum.Font.GothamBold
DevourButton.TextSize = 15
DevourButton.TextColor3 = Color3.new(1, 1, 1)
DevourButton.BorderSizePixel = 0
DevourButton.AutoButtonColor = true
Instance.new('UICorner', DevourButton).CornerRadius = UDim.new(0, 14)

DevourButton.MouseButton1Click:Connect(function()
    DevourButton.Text = 'WORKING...'
    DevourButton.AutoButtonColor = false
    local Character = LocalPlayer.Character
    local Humanoid = Character:FindFirstChildOfClass('Humanoid')
    local QuantumCloner = Backpack:FindFirstChild('Quantum Cloner')
    if QuantumCloner and Humanoid then
        Humanoid:EquipTool(QuantumCloner)
        task.wait()
        for _, tool in ipairs(Backpack:GetChildren()) do
            if tool:IsA('Tool') then
                tool.Parent = Character
            end
        end
        task.wait()
        QuantumCloner:Activate()
        task.delay(0.5, function()
            DevourButton.Text = 'FPS Devour (need auras)'
            DevourButton.AutoButtonColor = true
        end)
    end
end)

-- ========== AP SPAMMER ==========
local SpammerFrame = CreateStyledFrame(UDim2.fromOffset(180, 200), UDim2.fromScale(0.5, 0.25), "Spammer")

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 28)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = SpammerFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -28, 1, 0)
TitleLabel.Position = UDim2.new(0, 6, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "MLML673 HUB ap spammer"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local MinButton = Instance.new("TextButton")
MinButton.Size = UDim2.new(0, 22, 0, 22)
MinButton.Position = UDim2.new(1, -24, 0, 3)
MinButton.Text = "-"
MinButton.TextScaled = true
MinButton.Font = Enum.Font.GothamBold
MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MinButton.Parent = TitleBar
Instance.new("UICorner", MinButton).CornerRadius = UDim.new(0, 6)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Position = UDim2.new(0, 0, 0, 32)
Scroll.Size = UDim2.new(1, 0, 1, -34)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
Scroll.BackgroundTransparency = 1
Scroll.Parent = SpammerFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.Parent = Scroll

local minimized = false
MinButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    Scroll.Visible = not minimized
    SpammerFrame.Size = minimized and UDim2.fromOffset(180, 28) or UDim2.fromOffset(180, 200)
    MinButton.Text = minimized and "+" or "-"
end)

-- ========== SPEED BOOSTER ==========
local BoosterFrame = CreateStyledFrame(UDim2.new(0, 180, 0, 100), UDim2.new(0, 20, 0, 20), "Booster")

local BoosterTitle = Instance.new("TextLabel")
BoosterTitle.Size = UDim2.new(1, -20, 0, 20)
BoosterTitle.Position = UDim2.new(0, 10, 0, 8)
BoosterTitle.BackgroundTransparency = 1
BoosterTitle.Text = "MLML673 HUB"
BoosterTitle.TextColor3 = Color3.new(1, 0, 0)
BoosterTitle.Font = Enum.Font.GothamBold
BoosterTitle.TextSize = 14
BoosterTitle.TextXAlignment = Enum.TextXAlignment.Left
BoosterTitle.Parent = BoosterFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 50, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 40)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "SPEED:"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = BoosterFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 60, 0, 22)
SpeedBox.Position = UDim2.new(0, 65, 0, 39)
SpeedBox.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
SpeedBox.Text = "22.5"
SpeedBox.TextColor3 = Color3.new(1, 0, 0)
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.TextSize = 12
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = BoosterFrame
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", SpeedBox).Color = Color3.new(1, 0, 0)

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(0, 50, 0, 20)
JumpLabel.Position = UDim2.new(0, 10, 0, 65)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "JUMP:"
JumpLabel.TextColor3 = Color3.new(1, 1, 1)
JumpLabel.Font = Enum.Font.Gotham
JumpLabel.TextSize = 12
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpLabel.Parent = BoosterFrame

local JumpBox = Instance.new("TextBox")
JumpBox.Size = UDim2.new(0, 60, 0, 22)
JumpBox.Position = UDim2.new(0, 65, 0, 64)
JumpBox.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
JumpBox.Text = "35"
JumpBox.TextColor3 = Color3.new(1, 0, 0)
JumpBox.Font = Enum.Font.Gotham
JumpBox.TextSize = 12
JumpBox.ClearTextOnFocus = false
JumpBox.Parent = BoosterFrame
Instance.new("UICorner", JumpBox).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", JumpBox).Color = Color3.new(1, 0, 0)

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 16)
ToggleButton.Position = UDim2.new(1, -50, 0, 8)
ToggleButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
ToggleButton.Text = ""
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = BoosterFrame
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 8)

local ToggleBackground = Instance.new("Frame", ToggleButton)
ToggleBackground.Size = UDim2.new(1, 0, 1, 0)
ToggleBackground.BackgroundColor3 = Color3.new(0.8, 0, 0)
ToggleBackground.BackgroundTransparency = 0.3
ToggleBackground.ZIndex = 0
Instance.new("UICorner", ToggleBackground).CornerRadius = UDim.new(0, 8)

local Knob = Instance.new("Frame", ToggleButton)
Knob.Size = UDim2.new(0, 12, 0, 12)
Knob.Position = UDim2.new(0, 2, 0.5, 0)
Knob.AnchorPoint = Vector2.new(0, 0.5)
Knob.BackgroundColor3 = Color3.new(1, 1, 1)
Knob.ZIndex = 2
Instance.new("UICorner", Knob).CornerRadius = UDim.new(0, 6)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 40, 0, 12)
StatusLabel.Position = UDim2.new(1, -50, 0, 26)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "OFF"
StatusLabel.TextColor3 = Color3.new(1, 0, 0)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = BoosterFrame

-- ========== ESP ==========
local ESPFrame = CreateStyledFrame(UDim2.new(0, 180, 0, 70), UDim2.new(0, 20, 0, 140), "ESP")
local ESPStroke = Instance.new("UIStroke", ESPFrame)
ESPStroke.Color = Color3.new(0, 1, 1)
ESPStroke.Thickness = 2
ESPStroke.Transparency = 0.3

local ESPTitle = Instance.new("TextLabel")
ESPTitle.Size = UDim2.new(1, -20, 0, 20)
ESPTitle.Position = UDim2.new(0, 10, 0, 5)
ESPTitle.BackgroundTransparency = 1
ESPTitle.Text = "ESP MLML673"
ESPTitle.TextColor3 = Color3.new(0, 1, 1)
ESPTitle.Font = Enum.Font.GothamBold
ESPTitle.TextSize = 14
ESPTitle.TextXAlignment = Enum.TextXAlignment.Left
ESPTitle.Parent = ESPFrame

local ESPToggleButton = Instance.new("TextButton")
ESPToggleButton.Size = UDim2.new(0, 40, 0, 16)
ESPToggleButton.Position = UDim2.new(1, -50, 0, 8)
ESPToggleButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
ESPToggleButton.Text = ""
ESPToggleButton.AutoButtonColor = false
ESPToggleButton.Parent = ESPFrame
Instance.new("UICorner", ESPToggleButton).CornerRadius = UDim.new(0, 8)

local ESPToggleBackground = Instance.new("Frame", ESPToggleButton)
ESPToggleBackground.Size = UDim2.new(1, 0, 1, 0)
ESPToggleBackground.BackgroundColor3 = Color3.new(0.8, 0, 0)
ESPToggleBackground.BackgroundTransparency = 0.3
ESPToggleBackground.ZIndex = 0
Instance.new("UICorner", ESPToggleBackground).CornerRadius = UDim.new(0, 8)

local ESPKnob = Instance.new("Frame", ESPToggleButton)
ESPKnob.Size = UDim2.new(0, 12, 0, 12)
ESPKnob.Position = UDim2.new(0, 2, 0.5, 0)
ESPKnob.AnchorPoint = Vector2.new(0, 0.5)
ESPKnob.BackgroundColor3 = Color3.new(1, 1, 1)
ESPKnob.ZIndex = 2
Instance.new("UICorner", ESPKnob).CornerRadius = UDim.new(0, 6)

local ESPStatusLabel = Instance.new("TextLabel")
ESPStatusLabel.Size = UDim2.new(0, 40, 0, 12)
ESPStatusLabel.Position = UDim2.new(1, -50, 0, 26)
ESPStatusLabel.BackgroundTransparency = 1
ESPStatusLabel.Text = "OFF"
ESPStatusLabel.TextColor3 = Color3.new(1, 0, 0)
ESPStatusLabel.Font = Enum.Font.GothamBold
ESPStatusLabel.TextSize = 10
ESPStatusLabel.TextXAlignment = Enum.TextXAlignment.Center
ESPStatusLabel.Parent = ESPFrame

-- ========== STATE & LOGIC ==========
local BoosterEnabled = false
local ESPEnabled = false
local SpeedValue = 22.5
local JumpValue = 35
local ESPBoxes = {}
local TweenInfo1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenInfo2 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- ========== DRAGGING ==========
local function MakeDraggable(frame, handle)
    local dragging = false
    local dragStart, startPos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

MakeDraggable(SpammerFrame, TitleBar)
MakeDraggable(BoosterFrame, BoosterFrame)
MakeDraggable(ESPFrame, ESPFrame)

-- ========== BOOSTER TOGGLE ==========
ToggleButton.MouseButton1Click:Connect(function()
    BoosterEnabled = not BoosterEnabled
    local color = BoosterEnabled and Color3.new(0, 0.8, 0) or Color3.new(0.8, 0, 0)
    local pos = BoosterEnabled and UDim2.new(1, -14, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
    local text = BoosterEnabled and "ON" or "OFF"
    local col = BoosterEnabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    
    TweenService:Create(ToggleBackground, TweenInfo1, { BackgroundColor3 = color }):Play()
    TweenService:Create(Knob, TweenInfo2, { Position = pos }):Play()
    TweenService:Create(StatusLabel, TweenInfo1, { TextColor3 = col }):Play()
    StatusLabel.Text = text
end)

SpeedBox.FocusLost:Connect(function(entered)
    if entered then
        local num = tonumber(SpeedBox.Text)
        SpeedValue = (num and num > 0) and num or SpeedValue
        SpeedBox.Text = tostring(SpeedValue)
    end
end)

JumpBox.FocusLost:Connect(function(entered)
    if entered then
        local num = tonumber(JumpBox.Text)
        JumpValue = (num and num > 0) and num or JumpValue
        JumpBox.Text = tostring(JumpValue)
    end
end)

-- ========== BOOSTER HEARTBEAT ==========
RunService.Heartbeat:Connect(function()
    if not BoosterEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    
    if hum.MoveDirection.Magnitude > 0 then
        root.Velocity = Vector3.new(hum.MoveDirection.X * SpeedValue, root.Velocity.Y, hum.MoveDirection.Z * SpeedValue)
    end
    hum.JumpPower = JumpValue
end)

-- ========== AP SPAMMER ==========
local function SendCommands(name)
    local cmds = {";balloon "..name, ";rocket "..name, ";morph "..name, ";jumpscare "..name, ";jail "..name}
    local ch = TextChatService.TextChannels.RBXGeneral
    if ch then
        for _, cmd in ipairs(cmds) do
            ch:SendAsync(cmd)
            task.wait(0.12)
        end
    end
end

local function CreateButton(player)
    if player == LocalPlayer then return end
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 24)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Text = player.Name
    btn.Parent = Scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() SendCommands(player.Name) end)
end

local function RefreshList()
    for _, child in ipairs(Scroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, player in ipairs(Players:GetPlayers()) do
        CreateButton(player)
    end
    task.wait()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 4)
end

Players.PlayerAdded:Connect(RefreshList)
Players.PlayerRemoving:Connect(RefreshList)
RefreshList()

-- ========== ESP SYSTEM ==========
local function CreateESPBox(player)
    if player == LocalPlayer or ESPBoxes[player] then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local hl = Instance.new("Highlight")
    hl.Parent = char
    hl.FillColor = Color3.fromRGB(0, 255, 255)
    hl.OutlineColor = Color3.fromRGB(0, 255, 255)
    hl.FillTransparency = 0.3
    
    ESPBoxes[player] = hl
end

local function RemoveESPBox(player)
    if ESPBoxes[player] then
        ESPBoxes[player]:Destroy()
        ESPBoxes[player] = nil
    end
end

ESPToggleButton.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    local color = ESPEnabled and Color3.new(0, 0.8, 0) or Color3.new(0.8, 0, 0)
    local pos = ESPEnabled and UDim2.new(1, -14, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
    local text = ESPEnabled and "ON" or "OFF"
    local col = ESPEnabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    
    TweenService:Create(ESPToggleBackground, TweenInfo1, { BackgroundColor3 = color }):Play()
    TweenService:Create(ESPKnob, TweenInfo2, { Position = pos }):Play()
    TweenService:Create(ESPStatusLabel, TweenInfo1, { TextColor3 = col }):Play()
    ESPStatusLabel.Text = text
    
    if ESPEnabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then CreateESPBox(p) end
        end
    else
        for p, _ in pairs(ESPBoxes) do RemoveESPBox(p) end
    end
end)

Players.PlayerAdded:Connect(function(player)
    task.wait(0.5)
    if ESPEnabled then
        player.CharacterAdded:Connect(function()
            task.wait(0.1)
            CreateESPBox(player)
        end)
        CreateESPBox(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESPBox(player)
end)

print("✅ MLML673 HUB LOADED - Fully Optimized")
