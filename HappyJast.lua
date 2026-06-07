local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

getgenv().Settings = {
    Mouse = false,
    Hide = false,
    Range = 9e9,
    Sword = false,
}

-- [ ФУНКЦИИ ЛОГИКИ ] --
LocalPlayer:GetMouse().Button1Down:Connect(function()
    if Settings.Mouse and LocalPlayer:GetMouse().Hit then
        LocalPlayer.Character:PivotTo(CFrame.new(LocalPlayer:GetMouse().Hit.Position + Vector3.new(0, 3, 0)))
    end
end)

local function FireTouchTransmitter(part)
    local PartClass = part:FindFirstAncestorWhichIsA("Part")
    if firetouchinterest and LocalPlayer.Character then
        local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")
        if Character and part and PartClass then
            firetouchinterest(PartClass, Character, 0)
            firetouchinterest(PartClass, Character, 1)
            PartClass:PivotTo(Character:GetPivot())
        end
    elseif PartClass then
        LocalPlayer.Character:PivotTo(PartClass:GetPivot())
    end
end

-- [ СОЗДАНИЕ ИНТЕРФЕЙСА ] --
if CoreGui:FindFirstChild("UddachoJust_CustomMenu") then
    CoreGui["UddachoJust_CustomMenu"]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UddachoJust_CustomMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Основной контейнер (Ширина уменьшена до 150)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 150, 0, 40)
MainFrame.Position = UDim2.new(0.5, -75, 0.4, -20)
MainFrame.BackgroundTransparency = 1
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Верхняя панель (Топбар)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- Заголовок (Шрифт чуть уменьшен, чтобы влезть в 150px)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 30, 0, 0)
Title.Text = "UddachoJust 1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Кнопка закрытия (слева)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(0, 0, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSans
CloseBtn.TextSize = 16
CloseBtn.BackgroundTransparency = 1
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Нижнее тело меню (Вытянуто вниз под вертикальное расположение)
local MenuBody = Instance.new("Frame")
MenuBody.Size = UDim2.new(1, 0, 0, 340)
MenuBody.Position = UDim2.new(0, 0, 0, 40)
MenuBody.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MenuBody.BorderSizePixel = 0
MenuBody.ClipsDescendants = true
MenuBody.Visible = false
MenuBody.Parent = MainFrame

local BodyCorner = Instance.new("UICorner")
BodyCorner.CornerRadius = UDim.new(0, 8)
BodyCorner.Parent = MenuBody

-- Верхняя панель переключения вкладок внутри тела (вместо боковой)
local TabPanel = Instance.new("Frame")
TabPanel.Size = UDim2.new(1, 0, 0, 85)
TabPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TabPanel.BorderSizePixel = 0
TabPanel.Parent = MenuBody

-- Контейнер для контента страниц (занимает всё оставшееся место снизу)
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -10, 1, -95)
ContentContainer.Position = UDim2.new(0, 5, 0, 90)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MenuBody

-- Кнопка сворачивания/разворачивания (справа)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 30, 1, 0)
ToggleBtn.Position = UDim2.new(1, -30, 0, 0)
ToggleBtn.Text = "v"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSans
ToggleBtn.TextSize = 16
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Parent = TopBar

local isOpened = false
ToggleBtn.MouseButton1Click:Connect(function()
    isOpened = not isOpened
    if isOpened then
        ToggleBtn.Text = "^"
        MainFrame.Size = UDim2.new(0, 150, 0, 380)
        MenuBody.Visible = true
    else
        ToggleBtn.Text = "v"
        MenuBody.Visible = false
        MainFrame.Size = UDim2.new(0, 150, 0, 40)
    end
end)

local Pages = {}
local function CreatePage(name)
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, 0, 1, 0)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 3
    Scroll.Visible = false
    Scroll.Parent = ContentContainer
    
    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 5)
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Parent = Scroll
    
    Pages[name] = Scroll
    return Scroll
end

local MainScroll = CreatePage("Main")
local MovingScroll = CreatePage("Moving")
local ToolsScroll = CreatePage("Tools")

local function SelectTab(name)
    for k, v in pairs(Pages) do v.Visible = (k == name) end
end

local tabCount = 0
local function AddTabButton(name)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 22)
    Btn.Position = UDim2.new(0, 5, 0, 5 + (tabCount * 25))
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 13
    Btn.BorderSizePixel = 0
    Btn.Parent = TabPanel
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function() SelectTab(name) end)
    tabCount = tabCount + 1
end

AddTabButton("Main")
AddTabButton("Moving")
AddTabButton("Tools")
SelectTab("Main")

-- Конструкторы элементов управления (оптимизированы под 150px)
local function AddButton(page, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.Font = Enum.Font.SourceSansSemibold
    Btn.TextSize = 13
    Btn.TextWrapped = true
    Btn.BorderSizePixel = 0
    Btn.Parent = page
    
    local BCorn = Instance.new("UICorner")
    BCorn.CornerRadius = UDim.new(0, 5)
    BCorn.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function() pcall(callback) end)
end

local function AddToggle(page, text, varName, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.Text = text .. ": OFF"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Btn.Font = Enum.Font.SourceSansSemibold
    Btn.TextSize = 13
    Btn.TextWrapped = true
    Btn.BorderSizePixel = 0
    Btn.Parent = page
    
    local BCorn = Instance.new("UICorner")
    BCorn.CornerRadius = UDim.new(0, 5)
    BCorn.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        Settings[varName] = not Settings[varName]
        if Settings[varName] then
            Btn.Text = text .. ": ON"
            Btn.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            Btn.Text = text .. ": OFF"
            Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        pcall(callback, Settings[varName])
    end)
end

local function AddTextBox(page, placeholder, callback)
    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1, -5, 0, 35)
    Box.PlaceholderText = placeholder
    Box.Text = ""
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    Box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Box.Font = Enum.Font.SourceSans
    Box.TextSize = 12
    Box.TextWrapped = true
    Box.BorderSizePixel = 0
    Box.Parent = page
    
    local BCorn = Instance.new("UICorner")
    BCorn.CornerRadius = UDim.new(0, 5)
    BCorn.Parent = Box
    
    Box.FocusLost:Connect(function(enterPressed)
        if enterPressed then pcall(callback, Box.Text) end
    end)
end

-- [ НАПОЛНЕНИЕ ВКЛАДОК ] --
-- MAIN
AddButton(MainScroll, "Infinite Yield", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))() end)
AddButton(MainScroll, "Dark Dex", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua", true))() end)
AddButton(MainScroll, "Buy Item Checker", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxqLgnd/Utilities/main/BuyItemChecker.lua", true))() end)
AddButton(MainScroll, "WyConnect", function() loadstring(game:HttpGet("https://pastefy.app/16kxxJlL/raw", true))() end)
AddButton(MainScroll, "Remote Spy", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua", true))() end)
AddButton(MainScroll, "Turtle Spy", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Spy/main/source.lua", true))() end)
AddButton(MainScroll, "Remote Browser", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/RemoteBrowser", true))() end)
AddButton(MainScroll, "Dev Purchase's", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/refs/heads/main/Dev%20Product%20Purchase", true))() end)

-- MOVING
AddToggle(MovingScroll, "Mouse Teleport", "Mouse", function() end)
AddButton(MovingScroll, "Copy Position", function()
    local pos = LocalPlayer.Character.HumanoidRootPart:GetPivot()
    setclipboard(string.format("%d, %d, %d", pos.X, pos.Y, pos.Z))
end)
AddButton(MovingScroll, "Copy Teleport", function()
    local pos = LocalPlayer.Character.HumanoidRootPart:GetPivot()
    setclipboard(string.format("game:GetService('Players').LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(%d, %d, %d)))", pos.X+.5, pos.Y+.5, pos.Z+.5))
end)
AddButton(MovingScroll, "Copy TweenService", function()
    local pos = LocalPlayer.Character.HumanoidRootPart:GetPivot()
    setclipboard(string.format("game:GetService('TweenService'):Create(game:GetService('Players').LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2), {CFrame = CFrame.new(%d, %d, %d)}):Play()", pos.X, pos.Y, pos.Z))
end)

-- TOOLS
AddToggle(ToolsScroll, "Auto Hide Players", "Hide", function(state)
    while Settings.Hide do
        for _, v in pairs(Players:GetPlayers()) do
            if v.Name ~= LocalPlayer.Name and v.Character then v.Character:Destroy() end
        end
        task.wait(.2)
    end
end)
AddButton(ToolsScroll, "Fire All Prompts", function()
    for _, v in ipairs(Workspace:GetDescendants()) do if v:IsA("ProximityPrompt") then fireproximityprompt(v) end end
end)
AddButton(ToolsScroll, "HoldDuration 0", function()
    for _, v in pairs(Workspace:GetDescendants()) do if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end end
end)
AddButton(ToolsScroll, "Fire ClickDetectors", function()
    for _, v in ipairs(Workspace:GetDescendants()) do if v:IsA("ClickDetector") then fireclickdetector(v) end end
end)
AddButton(ToolsScroll, "Fire TouchInterests", function()
    for _, v in ipairs(Workspace:GetDescendants()) do if v:IsA("TouchTransmitter") then FireTouchTransmitter(v) end end
end)
AddTextBox(ToolsScroll, "Killaura Range (Enter)", function(text)
    local n = tonumber(text)
    if n then Settings.Range = n end
end)
AddToggle(ToolsScroll, "Sword Killaura", "Sword", function()
    while Settings.Sword do
        for _, v in pairs(Players:GetPlayers()) do
            local Dist = LocalPlayer:DistanceFromCharacter(v.Character:GetPivot().Position)
            if v.Character and v.Character.Name ~= LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") and Dist <= Settings.Range then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("Handle") then
                    tool:Activate()
                    firetouchinterest(tool.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(tool.Handle, v.Character.HumanoidRootPart, 1)
                end
            end
        end
        task.wait(.3)
    end
end)
