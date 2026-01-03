-- Fish Me - Rey_Script Hub
-- Created By ReyX

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local isSpamming = false
local spamThread = nil
local isVisible = true
local catchCount = 0
local selectedFishIndex = 1
local fishButtons = {}
local hue = 0

local fishData = {
    {name = "Black Maja", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(50, 50, 50), emoji = "🐋"},
    {name = "El Maja", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(255, 215, 0), emoji = "⭐"},
    {name = "Queen Grand Maja", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(255, 50, 255), emoji = "👑"},
    {name = "Queen Kraken", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(138, 43, 226), emoji = "🦑"},
    {name = "Kraken", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(75, 0, 130), emoji = "🐙"},
    {name = "Mega Hunt", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(255, 140, 0), emoji = "🦈"},
    {name = "Flame Megalodon", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(255, 69, 0), emoji = "🔥"},
    {name = "Naga", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(0, 255, 127), emoji = "🐍"},
    {name = "Shark Bone", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(220, 220, 220), emoji = "💀"},
    {name = "King Crab", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(255, 0, 0), emoji = "🦀"},
    {name = "KingJally Strong", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(0, 191, 255), emoji = "💪"},
    {name = "King Jelly", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(255, 105, 180), emoji = "🎀"},
    {name = "Sapu Sapu Goib", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(139, 69, 19), emoji = "🪵"},
    {name = "Abyssal Ness", rarity = "Secret", weight = 566.0, color = Color3.fromRGB(25, 25, 112), emoji = "🌊"}
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FishMeReyScriptHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true

local oldGui = playerGui:FindFirstChild("FishMeReyScriptHub")
if oldGui then
    oldGui:Destroy()
    task.wait(0.1)
end

screenGui.Parent = playerGui

local containerFrame = Instance.new("Frame")
containerFrame.Name = "Container"
containerFrame.Size = UDim2.new(0, 280, 0, 400)
containerFrame.Position = UDim2.new(1, -290, 0.5, -200)
containerFrame.BackgroundTransparency = 1
containerFrame.Parent = screenGui

local topBorder = Instance.new("Frame")
topBorder.Name = "TopBorder"
topBorder.Size = UDim2.new(1, 0, 0, 2)
topBorder.Position = UDim2.new(0, 0, 0, 0)
topBorder.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
topBorder.BorderSizePixel = 0
topBorder.ZIndex = 10
topBorder.Parent = containerFrame

local leftBorder = Instance.new("Frame")
leftBorder.Name = "LeftBorder"
leftBorder.Size = UDim2.new(0, 2, 1, 0)
leftBorder.Position = UDim2.new(0, 0, 0, 0)
leftBorder.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
leftBorder.BorderSizePixel = 0
leftBorder.ZIndex = 10
leftBorder.Parent = containerFrame

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(1, -2, 1, -2)
mainFrame.Position = UDim2.new(0, 2, 0, 2)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = containerFrame

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 38)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 8)
topBarCorner.Parent = topBar

local topBarFill = Instance.new("Frame")
topBarFill.Size = UDim2.new(1, 0, 0, 8)
topBarFill.Position = UDim2.new(0, 0, 1, -8)
topBarFill.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
topBarFill.BorderSizePixel = 0
topBarFill.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 180, 0, 16)
title.Position = UDim2.new(0, 10, 0, 4)
title.BackgroundTransparency = 1
title.Text = "🎣 Fish Me - Rey_Script Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 11
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local creatorLabel = Instance.new("TextLabel")
creatorLabel.Size = UDim2.new(0, 180, 0, 12)
creatorLabel.Position = UDim2.new(0, 10, 0, 22)
creatorLabel.BackgroundTransparency = 1
creatorLabel.Text = "Created By ReyX"
creatorLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
creatorLabel.Font = Enum.Font.Gotham
creatorLabel.TextSize = 8
creatorLabel.TextXAlignment = Enum.TextXAlignment.Left
creatorLabel.Parent = topBar

local counterFrame = Instance.new("Frame")
counterFrame.Size = UDim2.new(0, 50, 0, 24)
counterFrame.Position = UDim2.new(1, -110, 0.5, -12)
counterFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
counterFrame.BorderSizePixel = 0
counterFrame.Parent = topBar

local counterCorner = Instance.new("UICorner")
counterCorner.CornerRadius = UDim.new(0, 6)
counterCorner.Parent = counterFrame

local counterLabel = Instance.new("TextLabel")
counterLabel.Size = UDim2.new(1, 0, 1, 0)
counterLabel.BackgroundTransparency = 1
counterLabel.Text = "0"
counterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
counterLabel.Font = Enum.Font.GothamBold
counterLabel.TextSize = 13
counterLabel.Parent = counterFrame

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0, 28, 0, 28)
hideButton.Position = UDim2.new(1, -33, 0.5, -14)
hideButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
hideButton.BorderSizePixel = 0
hideButton.Text = "—"
hideButton.TextColor3 = Color3.fromRGB(200, 200, 220)
hideButton.Font = Enum.Font.GothamBold
hideButton.TextSize = 13
hideButton.AutoButtonColor = false
hideButton.Parent = topBar

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 6)
hideCorner.Parent = hideButton

local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -16, 1, -46)
contentFrame.Position = UDim2.new(0, 8, 0, 42)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local statsPanel = Instance.new("Frame")
statsPanel.Size = UDim2.new(1, 0, 0, 55)
statsPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
statsPanel.BorderSizePixel = 0
statsPanel.Parent = contentFrame

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 8)
statsCorner.Parent = statsPanel

local fishIcon = Instance.new("TextLabel")
fishIcon.Size = UDim2.new(0, 36, 0, 36)
fishIcon.Position = UDim2.new(0, 8, 0.5, -18)
fishIcon.BackgroundColor3 = fishData[1].color
fishIcon.BorderSizePixel = 0
fishIcon.Text = fishData[1].emoji
fishIcon.TextSize = 20
fishIcon.Parent = statsPanel

local fishIconCorner = Instance.new("UICorner")
fishIconCorner.CornerRadius = UDim.new(0, 6)
fishIconCorner.Parent = fishIcon

local fishName = Instance.new("TextLabel")
fishName.Size = UDim2.new(0, 200, 0, 18)
fishName.Position = UDim2.new(0, 50, 0, 10)
fishName.BackgroundTransparency = 1
fishName.Text = fishData[1].name
fishName.TextColor3 = Color3.fromRGB(255, 255, 255)
fishName.Font = Enum.Font.GothamBold
fishName.TextSize = 11
fishName.TextXAlignment = Enum.TextXAlignment.Left
fishName.Parent = statsPanel

local fishRarity = Instance.new("TextLabel")
fishRarity.Size = UDim2.new(0, 200, 0, 15)
fishRarity.Position = UDim2.new(0, 50, 0, 28)
fishRarity.BackgroundTransparency = 1
fishRarity.Text = "✨ " .. fishData[1].rarity .. " • " .. fishData[1].weight .. " kg"
fishRarity.TextColor3 = fishData[1].color
fishRarity.Font = Enum.Font.Gotham
fishRarity.TextSize = 9
fishRarity.TextXAlignment = Enum.TextXAlignment.Left
fishRarity.Parent = statsPanel

local selectLabel = Instance.new("TextLabel")
selectLabel.Size = UDim2.new(1, 0, 0, 16)
selectLabel.Position = UDim2.new(0, 0, 0, 60)
selectLabel.BackgroundTransparency = 1
selectLabel.Text = "SELECT FISH"
selectLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
selectLabel.Font = Enum.Font.GothamBold
selectLabel.TextSize = 9
selectLabel.TextXAlignment = Enum.TextXAlignment.Left
selectLabel.Parent = contentFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 0, 190)
scrollFrame.Position = UDim2.new(0, 0, 0, 78)
scrollFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 2
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 255)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = contentFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 8)
scrollCorner.Parent = scrollFrame

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 80, 0, 34)
gridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.Parent = scrollFrame

local scrollPadding = Instance.new("UIPadding")
scrollPadding.PaddingTop = UDim.new(0, 5)
scrollPadding.PaddingLeft = UDim.new(0, 5)
scrollPadding.PaddingRight = UDim.new(0, 5)
scrollPadding.PaddingBottom = UDim.new(0, 5)
scrollPadding.Parent = scrollFrame

for i, fish in ipairs(fishData) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 80, 0, 34)
    button.BackgroundColor3 = i == 1 and Color3.fromRGB(35, 35, 45) or Color3.fromRGB(25, 25, 35)
    button.BorderSizePixel = 0
    button.Text = ""
    button.AutoButtonColor = false
    button.LayoutOrder = i
    button.Parent = scrollFrame
    fishButtons[i] = button
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button
    
    if i == 1 then
        local glow = Instance.new("UIStroke")
        glow.Color = fish.color
        glow.Thickness = 1.5
        glow.Transparency = 0.4
        glow.Parent = button
    end
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 22, 0, 22)
    icon.Position = UDim2.new(0, 4, 0.5, -11)
    icon.BackgroundTransparency = 1
    icon.Text = fish.emoji
    icon.TextSize = 14
    icon.Parent = button
    
    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(0, 50, 0, 13)
    name.Position = UDim2.new(0, 28, 0, 5)
    name.BackgroundTransparency = 1
    name.Text = string.match(fish.name, "(%w+)$")
    name.TextColor3 = Color3.fromRGB(255, 255, 255)
    name.Font = Enum.Font.GothamBold
    name.TextSize = 8
    name.TextXAlignment = Enum.TextXAlignment.Left
    name.TextTruncate = Enum.TextTruncate.AtEnd
    name.Parent = button
    
    local weight = Instance.new("TextLabel")
    weight.Size = UDim2.new(0, 50, 0, 10)
    weight.Position = UDim2.new(0, 28, 0, 18)
    weight.BackgroundTransparency = 1
    weight.Text = fish.weight .. " kg"
    weight.TextColor3 = Color3.fromRGB(130, 130, 150)
    weight.Font = Enum.Font.Gotham
    weight.TextSize = 7
    weight.TextXAlignment = Enum.TextXAlignment.Left
    weight.Parent = button
    
    button.MouseButton1Click:Connect(function()
        selectedFishIndex = i
        fishIcon.Text = fish.emoji
        fishIcon.BackgroundColor3 = fish.color
        fishName.Text = fish.name
        fishRarity.Text = "✨ " .. fish.rarity .. " • " .. fish.weight .. " kg"
        fishRarity.TextColor3 = fish.color
        
        for idx, btn in pairs(fishButtons) do
            for _, child in pairs(btn:GetChildren()) do
                if child:IsA("UIStroke") then
                    child:Destroy()
                end
            end
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
        end
        
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
        
        local newGlow = Instance.new("UIStroke")
        newGlow.Color = fish.color
        newGlow.Thickness = 1.5
        newGlow.Transparency = 0.4
        newGlow.Parent = button
    end)
end

gridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 10)
end)

local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, 0, 0, 75)
buttonContainer.Position = UDim2.new(0, 0, 1, -75)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = contentFrame

local spamButton = Instance.new("TextButton")
spamButton.Size = UDim2.new(1, 0, 0, 32)
spamButton.Position = UDim2.new(0, 0, 0, 0)
spamButton.BackgroundColor3 = Color3.fromRGB(255, 50, 255)
spamButton.BorderSizePixel = 0
spamButton.Text = "🚀 START AUTO"
spamButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spamButton.Font = Enum.Font.GothamBold
spamButton.TextSize = 11
spamButton.AutoButtonColor = false
spamButton.Parent = buttonContainer

local spamCorner = Instance.new("UICorner")
spamCorner.CornerRadius = UDim.new(0, 8)
spamCorner.Parent = spamButton

local catchButton = Instance.new("TextButton")
catchButton.Size = UDim2.new(0.48, 0, 0, 28)
catchButton.Position = UDim2.new(0, 0, 0, 38)
catchButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
catchButton.BorderSizePixel = 0
catchButton.Text = "🎣 CATCH"
catchButton.TextColor3 = Color3.fromRGB(200, 200, 220)
catchButton.Font = Enum.Font.GothamBold
catchButton.TextSize = 10
catchButton.AutoButtonColor = false
catchButton.Parent = buttonContainer

local catchCorner = Instance.new("UICorner")
catchCorner.CornerRadius = UDim.new(0, 6)
catchCorner.Parent = catchButton

local resetButton = Instance.new("TextButton")
resetButton.Size = UDim2.new(0.48, 0, 0, 28)
resetButton.Position = UDim2.new(0.52, 0, 0, 38)
resetButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
resetButton.BorderSizePixel = 0
resetButton.Text = "🔄 RESET"
resetButton.TextColor3 = Color3.fromRGB(200, 200, 220)
resetButton.Font = Enum.Font.GothamBold
resetButton.TextSize = 10
resetButton.AutoButtonColor = false
resetButton.Parent = buttonContainer

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 6)
resetCorner.Parent = resetButton

local floatButton = Instance.new("TextButton")
floatButton.Size = UDim2.new(0, 38, 0, 38)
floatButton.Position = UDim2.new(1, -48, 0.5, -19)
floatButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
floatButton.BorderSizePixel = 0
floatButton.Text = "🎣"
floatButton.TextSize = 16
floatButton.Font = Enum.Font.GothamBold
floatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
floatButton.AutoButtonColor = false
floatButton.Visible = false
floatButton.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatButton

local floatStroke = Instance.new("UIStroke")
floatStroke.Color = Color3.fromRGB(255, 100, 255)
floatStroke.Thickness = 2
floatStroke.Transparency = 0.3
floatStroke.Parent = floatButton

RunService.RenderStepped:Connect(function()
    hue = (hue + 1) % 360
    local rgbColor = Color3.fromHSV(hue / 360, 1, 1)
    topBorder.BackgroundColor3 = rgbColor
    leftBorder.BackgroundColor3 = rgbColor
end)

local function catchFish()
    local fish = fishData[selectedFishIndex]
    local success, err = pcall(function()
        local args = {
            hookPosition = Vector3.new(2074.549560546875, 450.6968688964844, 179.74554443359375),
            name = fish.name,
            rarity = fish.rarity,
            weight = fish.weight
        }
        
        local yahiko = ReplicatedStorage:WaitForChild("FishingYahiko", 5)
        if not yahiko then
            warn("FishingYahiko not found")
            return
        end
        
        local giver = yahiko:FindFirstChild("YahikoGiver")
        if not giver then
            warn("YahikoGiver not found")
            return
        end
        
        giver:FireServer(args)
        catchCount = catchCount + 1
        counterLabel.Text = tostring(catchCount)
        
        TweenService:Create(counterFrame, TweenInfo.new(0.1), {Size = UDim2.new(0, 53, 0, 26)}):Play()
        task.wait(0.1)
        TweenService:Create(counterFrame, TweenInfo.new(0.15), {Size = UDim2.new(0, 50, 0, 24)}):Play()
    end)
    
    if not success then
        warn("Error:", err)
    end
end

local function toggleSpam()
    isSpamming = not isSpamming
    if isSpamming then
        spamButton.Text = "⏹ STOP AUTO"
        spamButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        
        spamThread = task.spawn(function()
            while isSpamming do
                catchFish()
                task.wait(0.05)
            end
        end)
    else
        spamButton.Text = "🚀 START AUTO"
        spamButton.BackgroundColor3 = Color3.fromRGB(255, 50, 255)
        
        if spamThread then
            task.cancel(spamThread)
            spamThread = nil
        end
    end
end

local function toggleUI()
    isVisible = not isVisible
    if isVisible then
        floatButton.Visible = false
        containerFrame.Visible = true
        containerFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(containerFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 280, 0, 400)}):Play()
    else
        TweenService:Create(containerFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.25)
        containerFrame.Visible = false
        floatButton.Visible = true
    end
end

local dragging = false
local dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    containerFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = containerFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

spamButton.MouseButton1Click:Connect(toggleSpam)
catchButton.MouseButton1Click:Connect(catchFish)
floatButton.MouseButton1Click:Connect(toggleUI)
hideButton.MouseButton1Click:Connect(toggleUI)

resetButton.MouseButton1Click:Connect(function()
    catchCount = 0
    counterLabel.Text = "0"
    TweenService:Create(counterFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(80, 255, 120)}):Play()
    task.wait(0.15)
    TweenService:Create(counterFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
end)

catchButton.MouseEnter:Connect(function()
    TweenService:Create(catchButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
end)

catchButton.MouseLeave:Connect(function()
    TweenService:Create(catchButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
end)

resetButton.MouseEnter:Connect(function()
    TweenService:Create(resetButton, TweenInfo.new(0.2), {Ba
