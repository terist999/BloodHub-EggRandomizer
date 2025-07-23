-- Created by bloodlust92
-- Splash loading screen + Rainbow progress bar
-- Followed by Egg Randomizer GUI

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ===== Loading Screen =====
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.Name = "BloodlustLoader"
screenGui.IgnoreGuiInset = true

local blackout = Instance.new("Frame", screenGui)
blackout.Size = UDim2.new(1,0,1,0)
blackout.BackgroundColor3 = Color3.new(0,0,0)
blackout.BorderSizePixel = 0

local barBg = Instance.new("Frame", screenGui)
barBg.Size = UDim2.new(0.6,0,0.05,0)
barBg.Position = UDim2.new(0.2,0,0.5,0)
barBg.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
barBg.BorderSizePixel = 0
local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.new(1,0,0)

local credit = Instance.new("TextLabel", screenGui)
credit.Size = UDim2.new(0,200,0,30)
credit.Position = UDim2.new(0.5,-100,0.95,0)
credit.BackgroundTransparency = 1
credit.Text = "Created by bloodlust92"
credit.Font = Enum.Font.FredokaOne
credit.TextSize = 20
credit.TextColor3 = Color3.new(1,0,0)

local function getRainbowColor(i)
    return Color3.fromHSV((tick()*0.3 + i/100)%1,1,1)
end

spawn(function()
    for i = 1, 100 do
        bar.Size = UDim2.new(i/100,0,1,0)
        bar.BackgroundColor3 = getRainbowColor(i)
        wait(0.03)
    end
    wait(0.5)
    screenGui:Destroy()
end)

-- ===== Egg Randomizer GUI =====
local petTable = {
    ["Common Egg"] = { "Dog", "Bunny", "Golden Lab" },
    ["Uncommon Egg"] = { "Chicken", "Black Bunny", "Cat", "Deer" },
    ["Rare Egg"] = { "Pig", "Monkey", "Rooster", "Orange Tabby", "Spotted Deer" },
    ["Legendary Egg"] = { "Cow", "Polar Bear", "Sea Otter", "Turtle", "Silver Monkey" },
    ["Mythical Egg"] = { "Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant" },
    ["Bug Egg"] = { "Snail", "Caterpillar", "Giant Ant", "Praying Mantis" },
    ["Night Egg"] = { "Frog", "Hedgehog", "Mole", "Echo Frog", "Night Owl" },
    ["Bee Egg"] = { "Bee", "Honey Bee", "Bear Bee", "Petal Bee" },
    ["Anti Bee Egg"] = { "Wasp", "Moth", "Tarantula Hawk" },
    ["Oasis Egg"] = { "Meerkat", "Sand Snake", "Axolotl" },
    ["Paradise Egg"] = { "Ostrich", "Peacock", "Capybara" },
    ["Dinosaur Egg"] = { "Raptor", "Triceratops", "Stegosaurus" },
    ["Primal Egg"] = { "Parasaurolophus", "Iguanodon", "Pachycephalosaurus" },
    ["Zen Egg"] = { "Shiba Inu", "Tanuki", "Kappa" },
}

local espEnabled = true
local truePetMap = {}

local function glitchLabelEffect(lbl)
    coroutine.wrap(function()
        local orig = lbl.TextColor3
        for _=1,2 do
            lbl.TextColor3 = Color3.new(1,0,0); wait(0.07)
            lbl.TextColor3 = orig;       wait(0.07)
        end
    end)()
end

local function applyEggESP(egg, pet)
    for _,v in ipairs(egg:GetDescendants()) do
        if v:IsA("BillboardGui") or v:IsA("Highlight") then v:Destroy() end
    end
    if not espEnabled then return end
    local base = egg:FindFirstChildWhichIsA("BasePart")
    if not base then return end
    local bb = Instance.new("BillboardGui", base)
    bb.Name = "PetBillboard"
    bb.Size = UDim2.new(0,270,0,50)
    bb.StudsOffset = Vector3.new(0,4.5,0)
    bb.AlwaysOnTop = true; bb.MaxDistance = 500

    local lbl = Instance.new("TextLabel", bb)
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = egg.Name.." | "..pet
    lbl.TextColor3 = Color3.fromRGB(255,0,0)
    lbl.TextStrokeTransparency = 0
    lbl.TextScaled = true; lbl.Font = Enum.Font.FredokaOne
    glitchLabelEffect(lbl)

    local hl = Instance.new("Highlight", egg)
    hl.Adornee = egg
    hl.FillColor = Color3.fromRGB(120,0,0)
    hl.OutlineColor = Color3.fromRGB(255,0,0)
    hl.FillTransparency = 0.3
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

local function getEggs(r)
    local res, char = {}, player.Character or player.CharacterAdded:Wait()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return res end
    for _,o in pairs(Workspace:GetDescendants()) do
        if o:IsA("Model") and petTable[o.Name] then
            if (o:GetModelCFrame().Position - root.Position).Magnitude<= (r or 60) then
                if not truePetMap[o] then
                    truePetMap[o] = petTable[o.Name][math.random(#petTable[o.Name])]
                end
                table.insert(res, o)
            end
        end
    end
    return res
end

local function randomize()
    for _,egg in ipairs(getEggs(60)) do
        local pet = petTable[egg.Name][math.random(#petTable[egg.Name])]
        truePetMap[egg] = pet
        applyEggESP(egg, pet)
    end
end

-- Create GUI after brief delay
delay(5, function()
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "BloodlustRandomizerUI"

    local fr = Instance.new("Frame", gui)
    fr.Size = UDim2.new(0,260,0,160)
    fr.Position = UDim2.new(0,20,0,100)
    fr.BackgroundColor3 = Color3.fromRGB(60,0,0)
    fr.BorderSizePixel = 0
    Instance.new("UICorner", fr).CornerRadius = UDim.new(0,10)

    local title = Instance.new("TextLabel", fr)
    title.Size = UDim2.new(1,0,0,30)
    title.BackgroundTransparency = 1
    title.Text = "🔪 Bloodlust Egg Randomizer"
    title.Font = Enum.Font.FredokaOne
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,0,0)

    local btn = Instance.new("TextButton", fr)
    btn.Size = UDim2.new(1,-20,0,40)
    btn.Position = UDim2.new(0,10,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(90,0,0)
    btn.Text = "🎲 Randomize Pets"
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 20
    btn.TextColor3 = Color3.new(1,0,0)
    btn.MouseButton1Click:Connect(randomize)

    local tgl = Instance.new("TextButton", fr)
    tgl.Size = UDim2.new(1,-20,0,40)
    tgl.Position = UDim2.new(0,10,0,90)
    tgl.BackgroundColor3 = Color3.fromRGB(50,0,0)
    tgl.Text = "👁️ ESP: ON"
    tgl.Font = Enum.Font.FredokaOne
    tgl.TextSize = 18
    tgl.TextColor3 = Color3.new(1,0,0)
    tgl.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        tgl.Text = espEnabled and "👁️ ESP: ON" or "👁️ ESP: OFF"
        for _,egg in ipairs(getEggs(60)) do
            if espEnabled then applyEggESP(egg, truePetMap[egg]) end
        end
    end)
end)
