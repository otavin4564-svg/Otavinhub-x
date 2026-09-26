-- Otavinhub X - PARTE 1
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OtavinhubX_Gui"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
local speedValue = 16
local invisibleActive = false
local aimbotActive = false
local hiddenParts = {}
local function getRoles()
    local roles = {Murderer = nil, Sheriff = nil, Innocents = {}}
    for _, p in pairs(Players:GetPlayers()) do
        if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then
            roles.Murderer = p
        elseif p.Backpack:FindFirstChild("Gun") or (p.Character and p.Character:FindFirstChild("Gun")) then
            roles.Sheriff = p
        else
            table.insert(roles.Innocents, p)
        end
    end
    return roles
end
-- Otavinhub X - PARTE 2
local MainToggle = Instance.new("TextButton")
MainToggle.Name = "MainToggle"
MainToggle.Size = UDim2.new(0, 60, 0, 60)
MainToggle.Position = UDim2.new(0.05, 0, 0.4, 0)
MainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainToggle.Text = "OX"
MainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainToggle.TextSize = 20
MainToggle.Font = Enum.Font.SourceSansBold
MainToggle.Parent = ScreenGui
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 30)
toggleCorner.Parent = MainToggle
local dragging, dragInput, dragStart, startPos
MainToggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainToggle.Position
    end
end)
MainToggle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainToggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
MainToggle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 280)
MainFrame.Position = UDim2.new(0.02, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = MainFrame
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Otavinhub X"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame
MainToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 100, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TabContainer.Parent = MainFrame
local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -100, 1, -40)
PageContainer.Position = UDim2.new(0, 100, 0, 40)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = MainFrame
local pages = {}
local function createTab(name, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, (order-1)*40)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = TabContainer
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.Visible = (order == 1)
    page.CanvasSize = UDim2.new(0, 0, 2, 0)
    page.ScrollBarThickness = 4
    page.Parent = PageContainer
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = page
    pages[name] = page
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
    return page
end
local sheriffPage = createTab("Sheriff", 1)
local playerPage = createTab("Player", 2)
local murdererPage = createTab("Murder", 3)
local function createButton(text, parent, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSans
    b.TextSize = 16
    b.Parent = parent
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 5) c.Parent = b
    b.MouseButton1Click:Connect(callback)
    return b
end
-- Otavinhub X - PARTE 3
local AimIcon = Instance.new("TextButton")
AimIcon.Size = UDim2.new(0, 50, 0, 50)
AimIcon.Position = UDim2.new(0.5, -25, 0.1, 0)
AimIcon.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
AimIcon.Text = "🎯"
AimIcon.TextSize = 25
AimIcon.Visible = false
AimIcon.Parent = ScreenGui
local aimCorner = Instance.new("UICorner") aimCorner.CornerRadius = UDim.new(0, 25) aimCorner.Parent = AimIcon
local function shootMurderer()
    local roles = getRoles()
    local target = roles.Murderer
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local gun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
        if gun then
            LocalPlayer.Character.Humanoid:EquipTool(gun)
            local args = {target.Character.HumanoidRootPart.Position}
            if gun:FindFirstChild("KnifeServer") then
                gun.KnifeServer.Shoot:InvokeServer(unpack(args))
            elseif ReplicatedStorage:FindFirstChild("Shoot") then
                ReplicatedStorage.Shoot:FireServer(unpack(args))
            end
        end
    end
end
AimIcon.MouseButton1Click:Connect(shootMurderer)
createButton("Criar Ícone Mira Manual", sheriffPage, function()
    AimIcon.Visible = not AimIcon.Visible
end)
local function hasLineOfSight(part1, part2)
    if not part1 or not part2 then return false end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {part1.Parent, part2.Parent}
    local result = workspace:Raycast(part1.Position, (part2.Position - part1.Position), params)
    return result == nil
end
local autoShootConnection
createButton("Auto Tiro Inteligente (On/Off)", sheriffPage, function()
    aimbotActive = not aimbotActive
    if aimbotActive then
        AimIcon.Visible = false
        autoShootConnection = RunService.Heartbeat:Connect(function()
            local roles = getRoles()
            local murderer = roles.Murderer
            if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local myPos = LocalPlayer.Character.HumanoidRootPart.Position
                local mudPos = murderer.Character.HumanoidRootPart.Position
                local dist = (myPos - mudPos).Magnitude
                if dist < 120 and hasLineOfSight(LocalPlayer.Character.HumanoidRootPart, murderer.Character.HumanoidRootPart) then
                    shootMurderer()
                end
            end
        end)
    else
        if autoShootConnection then autoShootConnection:Disconnect() end
    end
end)
local espActive = false
local espFolders = Instance.new("Folder", workspace)
espFolders.Name = "OX_ESP"
RunService.RenderStepped:Connect(function()
    if not espActive then espFolders:ClearAllChildren() return end
    local roles = getRoles()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local char = p.Character
            local hrp = char.HumanoidRootPart
            local color = Color3.fromRGB(0, 255, 0)
            if p == roles.Murderer then
                color = Color3.fromRGB(255, 0, 0)
            elseif p == roles.Sheriff then
                color = Color3.fromRGB(0, 0, 255)
            end
            local box = espFolders:FindFirstChild(p.Name)
            if not box then
                box = Instance.new("BoxHandleAdornment")
                box.Name = p.Name
                box.Target = hrp
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Size = Vector3.new(4, 6, 4)
                box.Transparency = 0.5
                box.Parent = espFolders
            end
            box.Color3 = color
        end
    end
end)
createButton("Ativar / Desativar ESP", playerPage, function()
    espActive = not espActive
end)
-- Otavinhub X - PARTE 4
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -10, 0, 40)
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.Parent = playerPage
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.5, 0, 1, 0)
SpeedLabel.Text = "Velocidade: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextSize = 16
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Parent = SpeedFrame
local btnMinus = Instance.new("TextButton")
btnMinus.Size = UDim2.new(0.2, 0, 1, 0)
btnMinus.Position = UDim2.new(0.5, 0, 0, 0)
btnMinus.Text = "-"
btnMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btnMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMinus.Parent = SpeedFrame
local btnPlus = Instance.new("TextButton")
btnPlus.Size = UDim2.new(0.2, 0, 1, 0)
btnPlus.Position = UDim2.new(0.75, 0, 0, 0)
btnPlus.Text = "+"
btnPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btnPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
btnPlus.Parent = SpeedFrame
local function updateSpeed()
    SpeedLabel.Text = "Velocidade: " .. tostring(speedValue)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
    end
end
btnMinus.MouseButton1Click:Connect(function() speedValue = math.max(16, speedValue - 5) updateSpeed() end)
btnPlus.MouseButton1Click:Connect(function() speedValue = math.min(200, speedValue + 5) updateSpeed() end)
local InvisibleIcon = Instance.new("TextButton")
InvisibleIcon.Size = UDim2.new(0, 75, 0, 40)
InvisibleIcon.Position = UDim2.new(0.5, -37, 0.25, 0)
InvisibleIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
InvisibleIcon.Text = "Invisible"
InvisibleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
InvisibleIcon.Visible = false
InvisibleIcon.Parent = ScreenGui
local invCorner = Instance.new("UICorner") invCorner.CornerRadius = UDim.new(0, 8) invCorner.Parent = InvisibleIcon
local function setInvisibility(active)
    local char = LocalPlayer.Character
    if not char then return end
    invisibleActive = active
    if active then
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then
                if p.Name ~= "HumanoidRootPart" then 
                    hiddenParts[p] = p.Transparency
                    p.Transparency = 0.7
                end
            end
        end
    else
        for part, originalTrans in pairs(hiddenParts) do
            if part and part.Parent then
                part.Transparency = originalTrans
            end
        end
        table.clear(hiddenParts)
    end
end
InvisibleIcon.MouseButton1Click:Connect(function()
    setInvisibility(not invisibleActive)
end)
createButton("Criar Ícone Invisible", playerPage, function()
    InvisibleIcon.Visible = not InvisibleIcon.Visible
end)
local FlingFrame = Instance.new("Frame")
FlingFrame.Size = UDim2.new(1, -10, 0, 35)
FlingFrame.BackgroundTransparency = 1
FlingFrame.Parent = playerPage
local function flingPlayer(targetPlayer)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = targetPlayer.Character.HumanoidRootPart
        local bf = Instance.new("BodyVelocity")
        bf.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bf.Velocity = Vector3.new(0, -500, 0)
        bf.Parent = hrp
        task.wait(0.2)
        bf:Destroy()
    end
end
local btnFlingSheriff = Instance.new("TextButton")
btnFlingSheriff.Size = UDim2.new(0.48, 0, 1, 0)
btnFlingSheriff.BackgroundColor3 = Color3.fromRGB(40, 60, 120)
btnFlingSheriff.Text = "Fling Sheriff"
btnFlingSheriff.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFlingSheriff.Parent = FlingFrame
local c1 = Instance.new("UICorner") c1.CornerRadius = UDim.new(0, 5) c1.Parent = btnFlingSheriff
btnFlingSheriff.MouseButton1Click:Connect(function() flingPlayer(getRoles().Sheriff) end)
local btnFlingMurder = Instance.new("TextButton")
btnFlingMurder.Size = UDim2.new(0.48, 0, 1, 0)
btnFlingMurder.Position = UDim2.new(0.52, 0, 0, 0)
btnFlingMurder.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
btnFlingMurder.Text = "Fling Murder"
btnFlingMurder.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFlingMurder.Parent = FlingFrame
local c2 = Instance.new("UICorner") c2.CornerRadius = UDim.new(0, 5) c2.Parent = btnFlingMurder
btnFlingMurder.MouseButton1Click:Connect(function() flingPlayer(getRoles().Murderer) end)
createButton("Anunciar no Chat", playerPage, function()
    local roles = getRoles()
    local sName = roles.Sheriff and roles.Sheriff.Name or "Nenhum"
    local mName = roles.Murderer and roles.Murderer.Name or "Nenhum"
    local message = "sherif("..sName..") murder("..mName..")"
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = TextChatService.TextChannels.RBXGeneral
        channel:SendAsync(message)
    else
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end)
createButton("Kill All (Apenas se for Murder)", murdererPage, function()
    local knife = LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
    if knife then
        LocalPlayer.Character.Humanoid:EquipTool(knife)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local stabArgs = {"Stab", p.Character.HumanoidRootPart}
                if knife:FindFirstChild("KnifeServer") then
                    knife.KnifeServer.Stab:InvokeServer(unpack(stabArgs))
                end
            end
        end
    end
end)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    updateSpeed()
    if invisibleActive then setInvisibility(true) end
end)
