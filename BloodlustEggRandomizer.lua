
--[[
    Bloodhub Script - Finalized Version (July 2025)
    Created by Blood.lust (@terist999)
    Features:
    - 3-minute animated loading screen (0–100%)
    - Funny rotating tips
    - Mini clicker game inside loading
    - Custom Bloodhub logo shown with fade animation
    - Main GUI only appears after loading completes
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Clear previous GUIs if re-injected
if PlayerGui:FindFirstChild("BloodhubGUI") then
    PlayerGui.BloodhubGUI:Destroy()
end

-- GUI container
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "BloodhubGUI"
screenGui.ResetOnSpawn = false

-- Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0

-- Logo Image
local logo = Instance.new("ImageLabel", mainFrame)
logo.Size = UDim2.new(0, 200, 0, 200)
logo.Position = UDim2.new(0.5, -100, 0.2, 0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://18423249307" -- Custom Bloodhub logo image (uploaded manually by user)
logo.ImageTransparency = 1

-- Fade in logo
TweenService:Create(logo, TweenInfo.new(3), {ImageTransparency = 0}):Play()

-- Loading Percentage
local percentLabel = Instance.new("TextLabel", mainFrame)
percentLabel.Size = UDim2.new(0, 300, 0, 50)
percentLabel.Position = UDim2.new(0.5, -150, 0.5, -25)
percentLabel.BackgroundTransparency = 1
percentLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
percentLabel.Font = Enum.Font.FredokaOne
percentLabel.TextScaled = true
percentLabel.Text = "Loading... 0%"

-- Loading Tips
local tipLabel = Instance.new("TextLabel", mainFrame)
tipLabel.Size = UDim2.new(0.6, 0, 0, 30)
tipLabel.Position = UDim2.new(0.5, -200, 0.65, 0)
tipLabel.BackgroundTransparency = 1
tipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
tipLabel.Font = Enum.Font.Gotham
tipLabel.TextScaled = true
tipLabel.Text = "Tip: Never trust a bunny with a bazooka."

-- Clicker Mini Game
local clickButton = Instance.new("TextButton", mainFrame)
clickButton.Size = UDim2.new(0, 200, 0, 50)
clickButton.Position = UDim2.new(0.5, -100, 0.8, 0)
clickButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
clickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
clickButton.Font = Enum.Font.FredokaOne
clickButton.TextScaled = true
clickButton.Text = "Click Me!"
local clicks = 0
clickButton.MouseButton1Click:Connect(function()
    clicks += 1
    clickButton.Text = "Clicks: " .. tostring(clicks)
end)

-- Tips rotation
local tips = {
    "Tip: Never trust a bunny with a bazooka.",
    "Tip: Don't water your cactus daily!",
    "Tip: Red is sus.",
    "Tip: Bees love disco. So do we.",
    "Tip: Loading faster if you smile.",
    "Tip: Pressing F4 doesn't do anything... or does it?",
}
spawn(function()
    while true do
        tipLabel.Text = tips[math.random(1, #tips)]
        wait(6)
    end
end)

-- Animate Loading %
spawn(function()
    for i = 0, 100 do
        percentLabel.Text = "Loading... " .. tostring(i) .. "%"
        wait(1.8) -- 3 minutes total: 180s / 100 steps = 1.8s per step
    end

    -- Fade out loading screen
    TweenService:Create(mainFrame, TweenInfo.new(2), {BackgroundTransparency = 1}):Play()
    TweenService:Create(logo, TweenInfo.new(2), {ImageTransparency = 1}):Play()
    TweenService:Create(percentLabel, TweenInfo.new(2), {TextTransparency = 1}):Play()
    TweenService:Create(tipLabel, TweenInfo.new(2), {TextTransparency = 1}):Play()
    TweenService:Create(clickButton, TweenInfo.new(2), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    wait(2.5)
    mainFrame:Destroy()

    -- Show Main GUI Here (after loading)
    local mainPanel = Instance.new("Frame", screenGui)
    mainPanel.Size = UDim2.new(0, 400, 0, 300)
    mainPanel.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainPanel.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
    mainPanel.Name = "MainGUI"

    local label = Instance.new("TextLabel", mainPanel)
    label.Size = UDim2.new(1, 0, 0.2, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    label.Text = "Welcome to Bloodhub!"

    -- Add more elements here for your GUI functionality
end)
