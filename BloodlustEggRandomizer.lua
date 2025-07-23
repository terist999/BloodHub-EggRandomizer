--[[ 
    BloodlustEggRandomizer by bloodlust92
    Final Version - Includes:
    - 5-minute engaging loading screen
    - Rainbow bar
    - Random loading tips
    - Movable GUI
    - 🅱️ Toggle
    - Randomize Pet with correct result display
--]]

-- == LOADING SCREEN ==
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

local blackout = Instance.new("Frame", screenGui)
blackout.BackgroundColor3 = Color3.new(0, 0, 0)
blackout.Size = UDim2.new(1, 0, 1, 0)
blackout.Position = UDim2.new(0, 0, 0, 0)
blackout.BorderSizePixel = 0

local barBackground = Instance.new("Frame", screenGui)
barBackground.Size = UDim2.new(0.6, 0, 0.05, 0)
barBackground.Position = UDim2.new(0.2, 0, 0.5, 0)
barBackground.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
barBackground.BorderSizePixel = 0

local loadingBar = Instance.new("Frame", barBackground)
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.Position = UDim2.new(0, 0, 0, 0)
loadingBar.BorderSizePixel = 0

local credit = Instance.new("TextLabel", screenGui)
credit.Text = "Created by bloodlust92"
credit.Font = Enum.Font.FredokaOne
credit.TextSize = 20
credit.TextColor3 = Color3.new(1, 0, 0)
credit.BackgroundTransparency = 1
credit.Position = UDim2.new(0.5, -100, 0.95, 0)
credit.Size = UDim2.new(0, 200, 0, 30)

local tipLabel = Instance.new("TextLabel", screenGui)
tipLabel.Text = "Loading Tip: Summoning bees..."
tipLabel.Font = Enum.Font.FredokaOne
tipLabel.TextSize = 18
tipLabel.TextColor3 = Color3.new(1, 1, 1)
tipLabel.BackgroundTransparency = 1
tipLabel.Position = UDim2.new(0.5, -150, 0.55, 30)
tipLabel.Size = UDim2.new(0, 300, 0, 30)

local tips = {
    "Summoning divine pets...",
    "Growing prehistoric fruit...",
    "Injecting bloodlust...",
    "Randomizing mutations...",
    "Tickling eggs gently...",
    "Calibrating 🅱️ Toggle...",
    "Loading animation prediction...",
    "Unleashing Disco Bee...",
}

local function getRainbowColor(i)
    local frequency = 0.1
    return Color3.fromHSV((tick() * frequency + i / 100) % 1, 1, 1)
end

spawn(function()
    for i = 1, 300 do  -- 5 minutes (300 seconds)
        loadingBar.Size = UDim2.new(i / 300, 0, 1, 0)
        loadingBar.BackgroundColor3 = getRainbowColor(i)
        if i % 15 == 0 then
            tipLabel.Text = "Loading Tip: " .. tips[math.random(1, #tips)]
        end
        wait(1)
    end
    screenGui:Destroy()
end)

-- == BLOODY EGG RANDOMIZER GUI ==

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "BloodyEggGUI"
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel", mainFrame)
title.Text = "🩸 Bloodlust Egg Randomizer"
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.TextColor3 = Color3.new(1, 0, 0)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1

local resultLabel = Instance.new("TextLabel", mainFrame)
resultLabel.Text = "Pet: ???"
resultLabel.Font = Enum.Font.FredokaOne
resultLabel.TextSize = 20
resultLabel.TextColor3 = Color3.new(1, 1, 1)
resultLabel.Size = UDim2.new(1, 0, 0, 40)
resultLabel.Position = UDim2.new(0, 0, 0.25, 0)
resultLabel.BackgroundTransparency = 1

local pets = {
    "Dog", "Bunny", "Golden Lab",
    "Chicken", "Cat",
    "Dragonfly", "Giant Ant", "Caterpillar", "Snail",
    "Queen Bee", "Disco Bee", "Blood Owl", "Night Owl", "Raccoon", "Fennec Fox",
    "Pterodactyl", "Raptor", "T-Rex"
}

local cooldown = false
local function randomizePet()
    if cooldown then return end
    cooldown = true
    local selected = pets[math.random(1, #pets)]
    resultLabel.Text = "Pet: " .. selected
    wait(10)
    cooldown = false
end

local randomizeBtn = Instance.new("TextButton", mainFrame)
randomizeBtn.Text = "🎲 Click Randomize"
randomizeBtn.Font = Enum.Font.FredokaOne
randomizeBtn.TextSize = 20
randomizeBtn.Size = UDim2.new(0.8, 0, 0, 40)
randomizeBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
randomizeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
randomizeBtn.TextColor3 = Color3.new(1, 1, 1)
randomizeBtn.MouseButton1Click:Connect(randomizePet)

local toggleButton = Instance.new("TextButton", gui)
toggleButton.Text = "🅱️"
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.TextSize = 30
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(1, -60, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Active = true
toggleButton.Draggable = true

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
