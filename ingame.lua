-- GraveHub + Plot Timer ESP + Speed 28.8 + Kick on Steal (fixed "YOU STOLE THE BRAINROT" message)
-- GUI smaller/less wide | X-Ray toggle | Plain watermark

local Players         = game:GetService("Players")
local Lighting        = game:GetService("Lighting")
local RunService      = game:GetService("RunService")
local UIS             = game:GetService("UserInputService")

local player          = Players.LocalPlayer
local playerGui       = player:WaitForChild("PlayerGui")
local Plots           = workspace:WaitForChild("Plots")

-- ────────────────────────────────────────────────
-- Plain text watermark (middle, fully visible, Gotham font)
-- ────────────────────────────────────────────────

local wmGui = Instance.new("ScreenGui")
wmGui.Name = "GraveHubWatermark"
wmGui.ResetOnSpawn = false
wmGui.IgnoreGuiInset = true
wmGui.Parent = playerGui

local wmText = Instance.new("TextLabel", wmGui)
wmText.Size = UDim2.new(0, 400, 0, 50)
wmText.Position = UDim2.new(0.5, -200, 0.5, -25)
wmText.BackgroundTransparency = 1
wmText.Text = "discord.gg/SPDrqA62Gb"
wmText.TextColor3 = Color3.fromRGB(255, 255, 255)
wmText.Font = Enum.Font.Gotham
wmText.TextSize = 26
wmText.TextTransparency = 0
wmText.TextStrokeTransparency = 0.5
wmText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
wmText.TextXAlignment = Enum.TextXAlignment.Center
wmText.TextYAlignment = Enum.TextYAlignment.Center

-- ────────────────────────────────────────────────
-- FPS / Ping / Players HUD (smaller)
-- ────────────────────────────────────────────────

local StatsGui = Instance.new("ScreenGui", playerGui)
StatsGui.Name = "GraveHubStats"
StatsGui.ResetOnSpawn = false
StatsGui.IgnoreGuiInset = true

local StatsFrame = Instance.new("Frame", StatsGui)
StatsFrame.Size       = UDim2.new(0, 220, 0, 24)
StatsFrame.Position   = UDim2.new(0.5, -110, 0, 8)
StatsFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
StatsFrame.BackgroundTransparency = 0.35
StatsFrame.BorderSizePixel = 0

Instance.new("UICorner", StatsFrame).CornerRadius = UDim.new(0, 8)
local statsStroke = Instance.new("UIStroke", StatsFrame)
statsStroke.Color = Color3.fromRGB(210, 15, 15)
statsStroke.Thickness = 1.5
statsStroke.Transparency = 0.3

local function createStatLabel(name, posX)
    local lbl = Instance.new("TextLabel", StatsFrame)
    lbl.Name = name
    lbl.Size       = UDim2.new(0.333, 0, 1, 0)
    lbl.Position   = UDim2.new(posX, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font       = Enum.Font.GothamSemibold
    lbl.TextSize   = 12
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    return lbl
end

local FpsLabel     = createStatLabel("FpsLabel",    0)
local PingLabel    = createStatLabel("PingLabel",   0.333)
local PlayersLabel = createStatLabel("PlayersLabel", 0.666)

FpsLabel.Text     = "FPS: --"
PingLabel.Text    = "Ping: --ms"
PlayersLabel.Text = "Players: --"

local lastFpsTime, frames = tick(), 0
RunService.RenderStepped:Connect(function()
    frames += 1
    local t = tick()
    if t > lastFpsTime + 1 then
        FpsLabel.Text = "FPS: " .. math.floor(frames / (t - lastFpsTime) + 0.5)
        frames = 0
        lastFpsTime = t
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        PingLabel.Text = "Ping: " .. math.floor(player:GetNetworkPing() * 1000 + 0.5) .. "ms"
        PlayersLabel.Text = "Players: " .. #Players:GetPlayers()
    end
end)

-- ────────────────────────────────────────────────
-- Main GUI (smaller & less wide)
-- ────────────────────────────────────────────────

local MainGui = Instance.new("ScreenGui", playerGui)
MainGui.Name = "GraveHubUI"
MainGui.ResetOnSpawn = false
MainGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size       = UDim2.new(0, 280, 0, 58)
MainFrame.Position   = UDim2.new(0.5, -140, 0.07, 40)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Active     = true
MainFrame.Draggable  = true
MainFrame.ClipsDescendants = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(210, 15, 15)
stroke.Thickness = 2
stroke.Transparency = 0.05

local title = Instance.new("TextLabel", MainFrame)
title.Size = UDim2.new(1,0,0,20)
title.BackgroundTransparency = 1
title.Text = "GRAVE HUB"
title.TextColor3 = Color3.fromRGB(240,240,240)
title.Font = Enum.Font.GothamBlack
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Center

local function createButton(name, posX)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Name = name
    btn.Size       = UDim2.new(0.333, -8, 0, 26)
    btn.Position   = UDim2.new(posX, 4, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.AutoButtonColor = false
    btn.Font       = Enum.Font.GothamSemibold
    btn.TextSize   = 11
    btn.TextColor3 = Color3.fromRGB(210, 210, 210)
    btn.TextXAlignment = Enum.TextXAlignment.Center

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(190,0,0)
    s.Thickness = 1.6
    s.Transparency = 0.2

    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(38,38,38) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(20,20,20) end)
    btn.MouseButton1Down:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(55,55,55) end)
    btn.MouseButton1Up:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(38,38,38) end)

    return btn
end

local ToggleButton     = createButton("ToggleBtn",   0)
local KickButton       = createButton("KickBtn",     0.333)
local StealKickButton  = createButton("StealKickBtn", 0.666)

ToggleButton.Text = "Locked"
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

KickButton.Text = "Kick"
KickButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
KickButton.TextColor3 = Color3.fromRGB(255, 255, 255)

StealKickButton.Text = "Kick on Steal: OFF"
StealKickButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
StealKickButton.TextColor3 = Color3.fromRGB(180, 180, 180)

-- ────────────────────────────────────────────────
-- Toggle Logic (Myskyp-style)
-- ────────────────────────────────────────────────

local isAllowed = false
local db = false

local function fireFriendPrompt()
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local obj = (prompt.ObjectText or ""):lower()
            local act = (prompt.ActionText or ""):lower()
            if obj:find("friend") or act:find("friend") or act:find("toggle") then
                fireproximityprompt(prompt)
                return true
            end
        end
    end
    return false
end

ToggleButton.MouseButton1Click:Connect(function()
    if db then return end
    db = true

    local success = fireFriendPrompt()

    if success then
        isAllowed = not isAllowed
        if isAllowed then
            ToggleButton.Text = "Allowed"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 200, 30)
        else
            ToggleButton.Text = "Locked"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        end
    else
        local oldText = ToggleButton.Text
        local oldColor = ToggleButton.BackgroundColor3
        ToggleButton.Text = "Not Found"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 140, 80)
        task.delay(1, function()
            ToggleButton.Text = oldText
            ToggleButton.BackgroundColor3 = oldColor
        end)
    end

    task.wait(1)
    db = false
end)

-- ────────────────────────────────────────────────
-- Kick Logic (manual)
-- ────────────────────────────────────────────────

local kickDb = false
KickButton.MouseButton1Click:Connect(function()
    if kickDb then return end
    kickDb = true

    KickButton.Text = "Kicking..."
    KickButton.BackgroundColor3 = Color3.fromRGB(255, 180, 60)

    pcall(function() player:Kick("Leaving • Grave Hub") end)

    task.delay(2, function()
        KickButton.Text = "Kick"
        KickButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        kickDb = false
    end)
end)

-- ────────────────────────────────────────────────
-- Kick on Steal (fixed message: "brainrot stolen")
-- ────────────────────────────────────────────────

local kickOnStealEnabled = false
local stealCheckConn

StealKickButton.Activated:Connect(function()
    kickOnStealEnabled = not kickOnStealEnabled

    if kickOnStealEnabled then
        StealKickButton.Text = "Kick on Steal: ON"
        StealKickButton.BackgroundColor3 = Color3.fromRGB(30, 200, 30)
        StealKickButton.TextColor3 = Color3.fromRGB(255, 255, 255)

        if not stealCheckConn then
            stealCheckConn = RunService.Heartbeat:Connect(function()
                if not kickOnStealEnabled then return end

                for _, gui in ipairs(playerGui:GetDescendants()) do
                    if gui:IsA("TextLabel") or gui:IsA("TextButton") then
                        local txt = gui.Text:lower()
                        if txt:sub(1, 9) == "you stole" then
                            player:Kick("brainrot stolen")  -- exactly as requested

                            if stealCheckConn then
                                stealCheckConn:Disconnect()
                                stealCheckConn = nil
                            end
                            return
                        end
                    end
                end
            end)
        end
    else
        StealKickButton.Text = "Kick on Steal: OFF"
        StealKickButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        StealKickButton.TextColor3 = Color3.fromRGB(180, 180, 180)

        if stealCheckConn then
            stealCheckConn:Disconnect()
            stealCheckConn = nil
        end
    end
end)

-- ────────────────────────────────────────────────
-- Potato Graphics (auto)
-- ────────────────────────────────────────────────

task.spawn(function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    Lighting.ClockTime = 12
    Lighting.FogEnd = 99999
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0

    pcall(function() Lighting.Technology = Enum.Technology.Voxel end)

    for _, obj in workspace:GetDescendants() do
        if obj:IsA("BasePart") then
            obj.CastShadow = false
            obj.Material = Enum.Material.Plastic
        elseif obj:IsA("Texture") or obj:IsA("SurfaceAppearance") or obj:IsA("Decal") then
            obj.Transparency = 1
        elseif obj:IsA("Light") or obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or
               obj:IsA("ColorCorrectionEffect") or obj:IsA("DepthOfFieldEffect") or
               obj:IsA("SunRaysEffect") or obj:IsA("Atmosphere") then
            obj.Enabled = false
        end
    end

    if Lighting:FindFirstChild("Clouds") then Lighting.Clouds.Enabled = false end
    workspace.Terrain.Transparency = 1
end)

-- ────────────────────────────────────────────────
-- Plot Timer ESP
-- ────────────────────────────────────────────────

local BaseESPs = {}

RunService.RenderStepped:Connect(function()
    for _, plot in ipairs(Plots:GetChildren()) do
        local purchases = plot:FindFirstChild("Purchases")
        local plotBlock = purchases and purchases:FindFirstChild("PlotBlock")
        local main = plotBlock and plotBlock:FindFirstChild("Main")

        local timerGui = main and main:FindFirstChild("BillboardGui")
        local timerText = timerGui and timerGui:FindFirstChild("RemainingTime")

        if main and timerText and timerText.Text ~= "" then
            if not BaseESPs[plot] then
                local gui = Instance.new("BillboardGui")
                gui.Size = UDim2.new(0, 140, 0, 35)
                gui.StudsOffset = Vector3.new(0, 5, 0)
                gui.AlwaysOnTop = true
                gui.Adornee = main
                gui.Parent = main

                local text = Instance.new("TextLabel", gui)
                text.Size = UDim2.fromScale(1,1)
                text.BackgroundTransparency = 1
                text.TextScaled = true
                text.Font = Enum.Font.GothamBlack
                text.TextColor3 = Color3.new(1,1,1)
                text.TextStrokeTransparency = 0
                text.TextStrokeColor3 = Color3.new(0,0,0)

                BaseESPs[plot] = gui
            end
            BaseESPs[plot].TextLabel.Text = timerText.Text
        elseif BaseESPs[plot] then
            BaseESPs[plot]:Destroy()
            BaseESPs[plot] = nil
        end
    end
end)

-- ────────────────────────────────────────────────
-- Name ESP
-- ────────────────────────────────────────────────

local nameESPTable = {}

local function updateNameESP()
    for _, gui in pairs(nameESPTable) do gui:Destroy() end
    nameESPTable = {}

    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, plr in Players:GetPlayers() do
        if plr == player then continue end
        local char = plr.Character
        if not char or not char:FindFirstChild("Head") then continue end

        local head = char.Head
        local gui = Instance.new("BillboardGui")
        gui.Name = "NameESP"
        gui.Adornee = head
        gui.Size = UDim2.new(0, 200, 0, 50)
        gui.StudsOffset = Vector3.new(0, 3, 0)
        gui.AlwaysOnTop = true
        gui.Parent = head

        local txt = Instance.new("TextLabel", gui)
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.TextColor3 = Color3.fromRGB(255,255,255)
        txt.TextStrokeTransparency = 0
        txt.TextStrokeColor3 = Color3.fromRGB(0,0,0)
        txt.Font = Enum.Font.GothamBold
        txt.TextSize = 14
        txt.TextScaled = true

        local dist = (hrp.Position - (char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position or Vector3.new())).Magnitude
        txt.Text = string.format("%s\n[%.0f]", plr.Name, dist)

        nameESPTable[plr] = gui
    end
end

updateNameESP()
Players.PlayerAdded:Connect(function() task.wait(0.5) updateNameESP() end)
Players.PlayerRemoving:Connect(function() task.wait(0.1) updateNameESP() end)

-- ────────────────────────────────────────────────
-- Speed Booster (28.8)
-- ────────────────────────────────────────────────

getgenv().EDITFLEXX_SPEED = getgenv().EDITFLEXX_SPEED or 28.8
local SPEED = getgenv().EDITFLEXX_SPEED
local speedEnabled = false
local speedConn

local function getChar()
    local char = player.Character or player.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid")
end

local function startSpeed()
    if speedConn then return end
    speedConn = RunService.Heartbeat:Connect(function()
        local _, hrp, hum = getChar()
        local dir = hum.MoveDirection
        if dir.Magnitude > 0 then
            hrp.AssemblyLinearVelocity = Vector3.new(dir.X * SPEED, hrp.AssemblyLinearVelocity.Y, dir.Z * SPEED)
        end
    end)
end

local function stopSpeed()
    if speedConn then speedConn:Disconnect() speedConn = nil end
end

local speedGui = Instance.new("ScreenGui", gethui and gethui() or playerGui)
speedGui.Name = "SpeedToggle"
speedGui.ResetOnSpawn = false

local sframe = Instance.new("Frame", speedGui)
sframe.Size = UDim2.fromOffset(60, 60)
sframe.Position = UDim2.fromScale(0.92, 0.45)
sframe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", sframe).CornerRadius = UDim.new(0, 12)

local sbtn = Instance.new("TextButton", sframe)
sbtn.Size = UDim2.fromOffset(52, 52)
sbtn.Position = UDim2.fromOffset(4, 4)
sbtn.Text = "SPD\n28.8"
sbtn.Font = Enum.Font.GothamBold
sbtn.TextSize = 14
sbtn.TextColor3 = Color3.new(1,1,1)
sbtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sbtn.AutoButtonColor = false
Instance.new("UICorner", sbtn).CornerRadius = UDim.new(0, 10)

local sdragging, sdragStart, sstartPos
sframe.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sdragging = true
        sdragStart = input.Position
        sstartPos = sframe.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then sdragging = false end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if sdragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - sdragStart
        sframe.Position = UDim2.new(sstartPos.X.Scale, sstartPos.X.Offset + delta.X, sstartPos.Y.Scale, sstartPos.Y.Offset + delta.Y)
    end
end)

sbtn.Activated:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        startSpeed()
        sbtn.BackgroundColor3 = Color3.fromRGB(80, 160, 255)
    else
        stopSpeed()
        sbtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- ────────────────────────────────────────────────
-- X-Ray Toggle (floating)
-- ────────────────────────────────────────────────

local xrayEnabled = false
local xrayTransparency = 0.75

local xrayGui = Instance.new("ScreenGui", gethui and gethui() or playerGui)
xrayGui.Name = "XRayToggle"
xrayGui.ResetOnSpawn = false

local xframe = Instance.new("Frame", xrayGui)
xframe.Size = UDim2.fromOffset(60, 60)
xframe.Position = UDim2.fromScale(0.92, 0.55)
xframe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", xframe).CornerRadius = UDim.new(0, 12)

local xbtn = Instance.new("TextButton", xframe)
xbtn.Size = UDim2.fromOffset(52, 52)
xbtn.Position = UDim2.fromOffset(4, 4)
xbtn.Text = "XRAY"
xbtn.Font = Enum.Font.GothamBold
xbtn.TextSize = 14
xbtn.TextColor3 = Color3.new(1,1,1)
xbtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
xbtn.AutoButtonColor = false
Instance.new("UICorner", xbtn).CornerRadius = UDim.new(0, 10)

local xdragging, xdragStart, xstartPos
xframe.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        xdragging = true
        xdragStart = input.Position
        xstartPos = xframe.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then xdragging = false end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if xdragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - xdragStart
        xframe.Position = UDim2.new(xstartPos.X.Scale, xstartPos.X.Offset + delta.X, xstartPos.Y.Scale, xstartPos.Y.Offset + delta.Y)
    end
end)

local function toggleXRay(enable)
    for _, part in workspace:GetDescendants() do
        if part:IsA("BasePart") and not part:IsDescendantOf(player.Character) then
            if enable then
                if part.Transparency < 0.3 then
                    part.Transparency = xrayTransparency
                end
            else
                if part.Transparency == xrayTransparency then
                    part.Transparency = 0
                end
            end
        end
    end
end

xbtn.Activated:Connect(function()
    xrayEnabled = not xrayEnabled
    toggleXRay(xrayEnabled)
    xbtn.BackgroundColor3 = xrayEnabled and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(40, 40, 40)
end)

print("GraveHub loaded | Kick on Steal message = 'brainrot stolen'")
