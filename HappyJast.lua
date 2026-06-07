local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

getgenv().Settings = {
    Version = 1.3,
    Mouse = false,
    Hide = false,
    Range = 9e9,
    Sword = false,
}

local function SendNotification(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 5
        })
    end)
end

LocalPlayer:GetMouse().Button1Down:Connect(function()
    if Settings.Mouse and LocalPlayer:GetMouse().Hit then
        LocalPlayer.Character:PivotTo(CFrame.new(LocalPlayer:GetMouse().Hit.Position + Vector3.new(0, 3, 0)))
    end
end)

local function FireTouchTransmitter(part)
    local PartClass = part:FindFirstAncestorWhichIsA("Part")
    if firetouchinterest then
        local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")
  
        if Character and part and PartClass then
            firetouchinterest(PartClass, Character, 0)
            firetouchinterest(PartClass, Character, 1)
            PartClass:PivotTo(Character:GetPivot())
        end
    else
        LocalPlayer.Character:PivotTo(PartClass:GetPivot())
    end
end

-- Загрузка стабильного интерфейса Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library:CreateWindow(string.format("xxqLgnd Script %s", Settings.Version), "DarkTheme")

-- ВКЛАДКА: MAIN SCRIPTS
local MainTab = Window:NewTab("Main Scripts")
local MainSection = MainTab:NewSection("Main Scripts")

MainSection:NewButton("Infinite Yield", "Запустить Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))()
end)

MainSection:NewButton("Dark Dex", "Запустить Dark Dex", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua", true))()
end)

MainSection:NewButton("Buy Item Checker", "Запустить Buy Item Checker", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xxqLgnd/Utilities/main/BuyItemChecker.lua", true))()
end)

MainSection:NewButton("WyConnect", "Запустить WyConnect", function()
    loadstring(game:HttpGet("https://pastefy.app/16kxxJlL/raw", true))()
end)

MainSection:NewButton("Remote Spy", "Запустить SimpleSpy V3", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua", true))()
end)

MainSection:NewButton("Turtle Spy", "Запустить Turtle Spy", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Spy/main/source.lua", true))()
end)

MainSection:NewButton("Remote Browser", "Запустить Remote Browser", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/RemoteBrowser", true))()
end)

MainSection:NewButton("Dev Purchase's", "Запустить Dev Purchase's", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/refs/heads/main/Dev%20Product%20Purchase", true))()
end)

MainSection:NewButton("Adonis Bypass", "Запустить Adonis Bypass", function()
    local adonisFound = false
    for _, v in pairs(game:GetDescendants()) do
        if v.Name == "__FUNCTION" then
            adonisFound = true
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua'))()
            break
        end
    end
    if not adonisFound then
        SendNotification("Error...", "Adonis didn't found")
    end
end)

-- ВКЛАДКА: MOVING
local MovingTab = Window:NewTab("Moving")
local MovingSection = MovingTab:NewSection("Moving")

MovingSection:NewToggle("Mouse Teleport", "Телепорт по клику мыши", function(state)
    Settings.Mouse = state
end)

MovingSection:NewButton("Copy Position", "Скопировать позицию", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format("%d, %d, %d", PlayerPosition.X, PlayerPosition.Y, PlayerPosition.Z))
    end)
end)

MovingSection:NewButton("Copy Teleport", "Скопировать код телепорта", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format("game:GetService('Players').LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(%d, %d, %d)))", PlayerPosition.X + .5, PlayerPosition.Y + .5, PlayerPosition.Z + .5))
    end)
end)

MovingSection:NewButton("Copy TweenService", "Скопировать код TweenService", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format("game:GetService('TweenService'):Create(game:GetService('Players').LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2), {CFrame = CFrame.new(%d, %d, %d)}):Play()", PlayerPosition.X, PlayerPosition.Y, PlayerPosition.Z))
    end)
end)

MovingSection:NewButton("Copy MoveTo", "Скопировать код MoveTo", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format([[
            local Humanoid = game:GetService('Players').LocalPlayer.Character.Humanoid
            Humanoid.WalkSpeed = 16
            Humanoid.JumpPower = 19
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            Humanoid:MoveTo(Vector3.new(%d, %d, %d))
            ]], PlayerPosition.X, PlayerPosition.Y, PlayerPosition.Z
        ))
    end)
end)

MovingSection:NewButton("Copy Lerp", "Скопировать код Lerp", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format([[
            local HumanoidRootPart = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart
            for i = 0, 1, 0.05 do
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(CFrame.new(%d, %d, %d), i); task.wait()
            end]], PlayerPosition.X, PlayerPosition.Y, PlayerPosition.Z
        ))
    end)
end)

-- ВКЛАДКА: TOOLS
local ToolsTab = Window:NewTab("Tools")
local ToolsSection = ToolsTab:NewSection("Tools")

ToolsSection:NewToggle("Auto Hide Players", "Удалить других игроков", function(state)
    task.spawn(function()
        Settings.Hide = state
        while true do
            if not Settings.Hide then return end
            for _, v in pairs(Players:GetPlayers()) do
                if v.Name ~= LocalPlayer.Name and v.Character then
                    v.Character:Destroy()
                end
            end
            task.wait(.1)
        end
    end)
end)

ToolsSection:NewButton("Fire All ProximityPrompt", "Активировать все промоуты", function()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            fireproximityprompt(v)
        end
    end
end)

ToolsSection:NewButton("HoldDuration 0", "Убрать задержку промоутов", function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            v.HoldDuration = 0
        end
    end
end)

ToolsSection:NewButton("Fire All ClickDetectors", "Активировать клик-детекторы", function()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end
    end
end)

ToolsSection:NewButton("Fire All Firetouchinterests", "Активировать TouchTransmitter", function()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("TouchTransmitter") then
            FireTouchTransmitter(v)
        end
    end
end)

ToolsSection:NewTextBox("Sword Killaura Range", "Дистанция киллауры", function(t)
    local tt = tonumber(t)
    if type(tt) == "number" then
        Settings.Range = tt
    end
end)

ToolsSection:NewToggle("Sword Killaura", "Включить Sword Killaura", function(state)
    task.spawn(function()
        Settings.Sword = state
        while true do
            if not Settings.Sword then return end
            for _,v in pairs(Players:GetPlayers()) do
                local Distance = LocalPlayer:DistanceFromCharacter(v.Character:GetPivot().Position)
                if v.Character and v.Character.Name ~= LocalPlayer.Name and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") and Distance <= Settings.Range then
                    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool and tool:FindFirstChild("Handle") then
                        tool:Activate()
                        for _,z in next, v.Character:GetChildren() do
                            if z:IsA("BasePart") then
                                firetouchinterest(tool.Handle, v, 0)
                                firetouchinterest(tool.Handle, v, 1)
                            end
                        end
                    end
                end
            end
            task.wait(.4)
        end
    end)
end)
