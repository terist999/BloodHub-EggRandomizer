--[[
    Bloodhub GUI - Advanced Bloody Loading Screen (3 minutes)
    By Blood.lust (@terist999)
    Features:
    - 3-minute animated loading screen with tips & mini-game
    - Displays logo (ninja red)
    - Tips change every 10 seconds
    - Mini-game: Click the bouncing blood icon to gain points
    - % Loading from 0 to 100
    - GUI only reveals after 3 minutes
    - GUI is draggable
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- Create Loading Screen
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = gui

-- Logo
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 200, 0, 200)
logo.Position = UDim2.new(0.5, -100, 0.1, 0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://17324108229" -- Ninja logo uploaded on your Roblox account
logo.Parent = loadingFrame

-- Loading Text
local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(0, 300, 0, 50)
loadingLabel.Position = UDim2.new(0.5, -150, 0.65, 0)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Loading: 0%"
loadingLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
loadingLabel.Font = Enum.Font.FredokaOne
loadingLabel.TextScaled = true
loadingLabel.Parent = loadingFrame

-- Tips
local tipsLabel = Instance.new("TextLabel")
tipsLabel.Size = UDim2.new(0, 600, 0, 40)
tipsLabel.Position = UDim2.new(0.5, -300, 0.8, 0)
tipsLabel.BackgroundTransparency = 1
tipsLabel.Text = "Tip: Press B to toggle GUI"
tipsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
tipsLabel.Font = Enum.Font.FredokaOne
tipsLabel.TextScaled = true
tipsLabel.Parent = loadingFrame

local funnyTips = {
    "Tip: Don't feed your bee hotdogs.",
    "Tip: Every fruit has a dream.",
    "Tip: Legendary pets don't like being called 'cute'.",
    "Tip: The 🅱️ icon is watching you.",
    "Tip: Click fast, but think faster.",
    "Tip: Avoid angry seagulls in summer."
}

-- Mini-game (Bouncing Blood Button)
local bloodBtn = Instance.new("TextButton")
bloodBtn.Text = "🩸"
bloodBtn.Size = UDim2.new(0, 60, 0, 60)
bloodBtn.Position = UDim2.new(0.5, -30, 0.5, -30)
bloodBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
bloodBtn.TextScaled = true
bloodBtn.Font = Enum.Font.FredokaOne
bloodBtn.TextColor3 = Color3.new(1,1,1)
bloodBtn.Parent = loadingFrame

local score = 0
bloodBtn.MouseButton1Click:Connect(function()
    score += 1
    tipsLabel.Text = "Mini-game Score: " .. score
end)

-- Bounce animation
spawn(function()
    local direction = Vector2.new(1, 1)
    while true do
        bloodBtn.Position = bloodBtn.Position + UDim2.new(0.01 * direction.X, 0, 0.01 * direction.Y, 0)
        if bloodBtn.Position.X.Offset <= 0 or bloodBtn.Position.X.Offset >= gui.AbsoluteSize.X - 60 then direction = Vector2.new(-direction.X, direction.Y) end
        if bloodBtn.Position.Y.Offset <= 0 or bloodBtn.Position.Y.Offset >= gui.AbsoluteSize.Y - 60 then direction = Vector2.new(direction.X, -direction.Y) end
        wait(0.03)
    end
end)

-- % Loader
spawn(function()
    for i = 0, 100 do
        loadingLabel.Text = "Loading: " .. i .. "%"
        wait(1.8) -- 180s total ~ 3 minutes
    end
end)

-- Tips rotator
spawn(function()
    while true do
        tipsLabel.Text = funnyTips[math.random(1, #funnyTips)]
        wait(10)
    end
end)

-- Show Main GUI after loading
wait(180) -- 3 minutes
loadingFrame:Destroy()

-- Main GUI Setup
local mainGui = Instance.new("Frame")
mainGui.Size = UDim2.new(0, 400, 0, 300)
mainGui.Position = UDim2.new(0.5, -200, 0.5, -150)
mainGui.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
mainGui.BorderSizePixel = 0
mainGui.Parent = gui

-- Drag support
local dragging, offset
mainGui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        offset = input.Position - mainGui.Position
    end
end)
mainGui.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
mainGui.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        mainGui.Position = UDim2.new(0, input.Position.X - offset.X.Offset, 0, input.Position.Y - offset.Y.Offset)
    end
end)

-- Placeholder Label
local welcome = Instance.new("TextLabel")
welcome.Size = UDim2.new(1, 0, 0, 50)
welcome.Position = UDim2.new(0, 0, 0, 0)
welcome.BackgroundTransparency = 1
welcome.Text = "Welcome to BloodHub 💀"
welcome.TextColor3 = Color3.new(1, 0, 0)
welcome.TextScaled = true
welcome.Font = Enum.Font.FredokaOne
welcome.Parent = mainGui
